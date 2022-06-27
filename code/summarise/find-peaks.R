# Explore features of projections:
# - number of peaks
# - size of peaks
# - timing of peaks
# - duration of waves (peak to peak)
# in the
# - individual models, quantile probabilities taken from samples
# - ensemble models
library(here)
library(dplyr)
library(lubridate)
library(ggpmisc)

# example
source(here("code", "load", "load_local_results.R"))
source(here("code", "load", "scenarios.R"))
source(here("code", "load", "plot_palettes.R"))

quantile_levels = c(0, 0.05, 0.25, 0.5, 0.75, 0.95, 1)

#
params <- list("round" = 1)
source(here("code", "report", "prep.R"))

# load data
data <- results_multi_country

# add year-quarters to data
data <- data |>
  mutate(quarter = as.factor(quarter(target_end_date, type = "year.quarter")),
         quarter_first = quarter(target_end_date, type = "date_first"),
         quarter_last = quarter(target_end_date, type = "date_last"))

quarter_labels <- data |>
  distinct(quarter, quarter_first, quarter_last) %>%
  mutate(months = paste0(month(quarter_first, label = TRUE),
                         "-",
                         month(quarter_last, label = TRUE),
                         "'",
                         substr(year(quarter_last), 3, 4))) |>
  pull(months, quarter)

data <- data |>
  select(-c(quarter_first, quarter_last)) |>
  mutate(quarter = recode(quarter, !!!quarter_labels))

# Detect peaks ----------------------------------------------------
waves <- data %>%
  group_by(model, scenario_label,
           location, target_variable,
           sample) %>%
  mutate(peak = ggpmisc:::find_peaks(x = value, span = 5),
         valley = ggpmisc:::find_peaks(x = -value, span = 5))

# Summarise peaks ---------------------------------------------------------
peaks <- filter(waves, peak) |>
  #Aut/winter
  filter(quarter %in% c("Oct-Dec'22", "Jan-Mar'23") &
           target_variable %in% c("inc case", "inc hosp", "inc icu")) |>
  mutate(target_variable = as.factor(target_variable))

# number of peaks ---------------------------------------------------------

# Number of peaks per year-quarter
peaks_n <- peaks |>
  count(sample,
        model, scenario_label, location, target_variable,
        name = "peaks") |>
  ungroup() |>
  group_by(model, scenario_label, location, target_variable,
           ) |>
  summarise(value = round(quantile(peaks, quantile_levels)),
            name = paste0("q", sub("\\.", "_", quantile_levels))) |>
  pivot_wider()

peaks_n |>
  filter(target_variable %in% c("inc case",
                                "inc hosp", "inc icu")) |>
  mutate(#quarter = as.factor(quarter),
         target_variable = as.factor(target_variable)) |>
  ggplot(aes(col = model, fill = model,
             x = scenario_label)) +
  geom_point(aes(y = q0_5),
             position = position_dodge(0.5)) +
  geom_linerange(aes(ymin = q0_05, ymax = q0_95),
                 position = position_dodge(0.5)) +
  scale_y_continuous(breaks = c(0:50),
                     labels = c(0:50)) +
  labs(y = "Number of peaks",
       x = NULL,
       subtitle = "Number of peaks over October 2022 - March 2023",
       col = NULL, fill = NULL) +
  facet_grid(c("location",
               "target_variable"),
             scales = "free", drop = TRUE) +
  theme(legend.position = "top",
        axis.text.x = element_text(angle = 10))

ggsave(here("n_peaks.png"), width = 8, height = 7)


# Summary of the maximum of each peak ---------------------------------
# Size of largest peak relative to largest previous peak
truth <- load_truth(
  truth_source = "JHU",
  temporal_resolution = "weekly",
  hub = "ECDC") |>
  select(-model)

truth_peaks <- truth |>
  mutate(value_100k = value / population * 100000) |>
  group_by(location, target_variable) |>
  filter(value == max(value)) %>%
  select(location, target_variable, value_100k_alltime = value_100k)

peaks_max <- peaks |>
  # add truth
  left_join(truth_peaks, by = c("location", "target_variable")) |>
  group_by(sample, model, scenario_label, location, target_variable,
           #quarter
           ) |>
  filter(value_100k == max(value_100k)) |>
  ungroup()

# Plot: boxplot uncertainty around value at peak
peaks_max |>
  group_by(model, scenario_label, location, target_variable,
           #quarter
           ) |>
  ggplot(aes(x = scenario_label,
             col = model)) +
  # Boxplot all samples' maximum values
  geom_boxplot(aes(y = value_100k), outlier.shape = 1) +
  # Add dotted line to indicate highest observed peak
  geom_hline(aes(yintercept = value_100k_alltime), lty = 3) +
  # Format
  scale_colour_manual(values = palette$models, drop = TRUE) +
  labs(y = "Peak incidence per 100k", x = NULL,
       col = NULL, fill = NULL,
       subtitle = "Estimated size of largest peak") +
  theme(legend.position = "top") +
  facet_grid(rows = vars(location),
             cols = vars(target_variable),
             scales = "free",
             drop = TRUE)

ggsave(here("size_peaks.png"), width = 10, height = 10)






