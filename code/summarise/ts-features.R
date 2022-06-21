# Analyse scenario projections using features of time series
library(here)
library(dplyr)
library(lubridate)
library(tsfeatures)
library(zoo)
library(purrr)
library(ggplot2)
library(tidyr)
theme_set(theme_bw() +
            theme(legend.position = "bottom"))

source(here("code", "load", "load_local_results.R"))
# get scenario metadata
source(here("code", "load", "scenarios.R"))

# convert values from a single projection to a ts vector
ts_convert <- function(projection) {
  ts_value <- ts(projection$value,
                 start = decimal_date(
                   min(projection$target_end_date)),
                 deltat = 1/52)
  return(ts_value)
}

# Get data ----------------------------------------------------------------
# Set round or pass through environment
round <- 1

# load only specific scenario meta-data
scenario_round_metadata <- scenarios[[paste0("round_", round)]]

# Get results
results <- load_local_results(round = round)

# divide into single projections
single_projection_variables <- c("model", "scenario_id", "location",
                                 "target_variable")

# split by samples
results_target <- results %>%
  group_by(across(all_of(c(single_projection_variables, "sample")))) %>%
  group_split()

# get names
results_target_unique <- results %>%
  distinct(across(all_of(c(single_projection_variables, "sample")))) %>%
  mutate(index = row_number())

# get features of each projection
# features <- map_dfr(results_target,
#                  ~ function(ts_convert(.x))) %>%
#   mutate(index = row_number()) %>%
#   left_join(results_target_unique, by = "index")


# Peaks -------------------------------------------------------------------
results_filter <- filter(results, location == "AT" &
                           target_variable == "inc case" &
                           scenario_id == "A-2022-05-22" &
                           model == "USC-SIkJalpha")

peaks <- results_filter %>%
  group_by(across(all_of(c("model", "scenario_id", "location",
                           "target_variable", "sample")))) %>%
  mutate(year = isoyear(target_end_date),
         quarter = quarter(target_end_date),
         peak = ggpmisc:::find_peaks(x = value, span = 5),
         valley = ggpmisc:::find_peaks(x = -value, span = 5),
         model_sample = paste0(model, sample),
         scenario_sample = paste0(scenario_label, sample)) %>%
  filter(sample < 5)

quarters <- distinct(results, target_end_date) %>%
  mutate(quarter = as.factor(quarter(target_end_date, type = "year.quarter")),
       quarter_start = quarter(target_end_date, type = "date_first"),
       quarter_end = quarter(target_end_date, type = "date_last"),
       value = 1,
       model_sample = NA)


# plot peaks and valleys
peaks %>%
  ggplot(aes(x = target_end_date, y = value, col = model_sample)) +
  geom_line() +
  geom_point(data = filter(peaks, peak), col = "red") +
  geom_point(data = filter(peaks, valley), col = "green") +
  #geom_tile(aes(fill = quarter)) +
  geom_rect(aes(xmin = quarter_start, xmax = quarter_end,
                ymin = -0.5, ymax = Inf,
                fill = quarter),
            data = quarters,
            alpha = 0.01, colour = NA)

# wave summaries
peak_valley <- peaks %>%
  filter(peak | valley) %>%
  arrange(target_end_date) %>%
  mutate(distance_from = value - lag(value),
         distance_to = lead(value) - value,
         duration_from = target_end_date - lag(target_end_date),
         duration_to = lead(target_end_date) - target_end_date) %>%
  filter(peak)

# analysis
# - number of peaks in each sample
# - average number of peaks in each model/scenario
# - difference between peak sizes in each sample
# -
# - divide by season: filter summer/winter/autumn/spring
# - duration of wave (valley - valley)
#

peak_summary <- peak_valley %>%
  ungroup() %>%
  group_by(location, target_variable, model, scenario_label,
           sample) %>%
  summarise(median = quantile(value, probs = 0.5),
            lo = quantile(value, probs = 0.01),
            hi = quantile(value, probs = 0.99),
            n = n())





