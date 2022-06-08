# Analyse scenario projections using features of time series
library(here)
library(dplyr)
library(lubridate)
library(tsfeatures)
library(purrr)
library(ggplot2)
library(tidyr)
theme_set(theme_bw() +
            theme(legend.position = "bottom"))

source(here("code", "load", "load_local_results.R"))
# get scenario metadata
source(here("code", "load", "scenarios.R"))

# convert values from a single projection to ts
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

results_target_unique <- results %>%
  distinct(across(all_of(c(single_projection_variables, "sample")))) %>%
  mutate(index = row_number())

results_target <- results %>%
  group_by(across(all_of(c(single_projection_variables, "sample")))) %>%
  group_split()

# get features of each projection
features <- map_dfr(results_target,
                 ~ tsfeatures(ts_convert(.x),
                              features = c("crossing_points",
                                           "flat_spots",
                                           "stability",
                                           "lumpiness")))

features_by_model <- features %>%
  mutate(index = row_number()) %>%
  left_join(results_target_unique, by = "index")


#########
single_result <- results_target[[1]]
single_ts <- ts_convert(single_result)
single_ts_outliers <- tsoutliers::tso(single_ts)
# AO = additive outliers
# LS = level shifts
# TC = temporary changes

##
# peak over a sliding window
plot(zoo::rollmax(single_ts, 5))

# Specify how many samples breach a threshold

features <- map_dfr(results_target,
                    ~ tsfeatures(ts_convert(.x),
                                 features = c("crossing_points",
                                              "flat_spots",
                                              "stability",
                                              "lumpiness")))

features_by_model <- features %>%
  mutate(index = row_number()) %>%
  left_join(results_target_unique, by = "index")










