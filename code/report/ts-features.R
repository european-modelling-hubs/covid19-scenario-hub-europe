# Analyse scenario projections using features of time series
library(here)
library(dplyr)
library(lubridate)
library(tsfeatures)
library(purrr)

# convert values from a single projection to ts
ts_convert <- function(projection) {
  ts_value <- ts(projection$value,
                 start = decimal_date(
                   min(projection$target_end_date)),
                 frequency = 1)
  return(ts_value)
}

# get projections
source(here("code", "load", "local-results.R"))
results <- results %>%
  filter(type == "quantile")

# divide into single projections
single_projection_variables <- c("model", "scenario", "location", "target_variable")

results_target_unique <- results %>%
  distinct(across(all_of(c(single_projection_variables, "quantile")))) %>%
  mutate(index = row_number())

results_target <- results %>%
  group_by(across(all_of(c(single_projection_variables, "quantile")))) %>%
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

# Explore a single target
library(ggplot2)
library(tidyr)
theme_set(theme_bw() +
            theme(legend.position = "bottom"))
de_features <- filter(features_by_model,
                      location == "DE" &
                        target_variable == "inc case")

###
de_features_plot <- de_features %>%
  filter(quantile %in% c(0.05, 0.5, 0.95))
  select(-index) %>%
  pivot_wider(names_from = quantile, names_prefix = "q",
              values_from = c(flat_spots, stability,
                              lumpiness, crossing_points))

de_features_plot %>%
  ggplot(aes(x = scenario, col = model, fill = model)) +
  geom_point(aes(y = crossing_points_q0.5)) +
  geom_linerange(aes(ymin = crossing_points_q0.05,
                  ymax = crossing_points_q0.95))

### single summary measure - median weighted by quantile
de_feat_weight <- de_features %>%
  mutate(quantile_weighting = ifelse(quantile > 0.5,
                                     1 - quantile,
                                     quantile),
         across(crossing_points:lumpiness,
                ~ quantile_weighting * .x)) %>%
  group_by(across(all_of(single_projection_variables))) %>%
  summarise(across(crossing_points:lumpiness, median))

de_feat_weight %>%
  pivot_longer(names_to = "feature", values_to = "value",
               cols = crossing_points:lumpiness) %>%
  ggplot(aes(x = model, col = scenario)) +
  geom_point(aes(y = value)) +
  facet_wrap("feature", scales = "free")

# differentiate between models = models on x axis
# differentiate betwen scenarios = scenarios on x axis, models as col/fill

