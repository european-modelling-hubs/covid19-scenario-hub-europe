interactive <- FALSE

library(here)
library(ggplot2)
source(here("code", "load.R"))

# load results - only inc death target
results <- load_results(local = TRUE,
                        round = 1,
                        n_model_min = 2) |>
  filter(target_variable == "inc death")

# score ------------------------------
mae <- results |>
  filter(!is.na(obs)) |>
  mutate(ae = abs(value_100k - obs_100k)) |>
  group_by(location, target_variable,
           model, sample, scenario_id) |>
  summarise(mae = mean(ae))

# explore MAE --------------------------------------
if (interactive) {
  # PLOT by frequency
  mae |>
    ggplot(aes(col = model)) +
    geom_histogram(aes(x = mae),
                   fill = "transparent",
                   binwidth = 0.1) +
    theme(legend.position = "bottom") +
    facet_grid(rows = vars(location),
               cols = vars(scenario_id),
               scales = "fixed") +
    theme_bw() +
    theme(legend.position = "bottom")

  # PLOT by sample
  mae |>
    ggplot(aes(x = sample, col = model)) +
    geom_point(aes(y = mae), alpha = 0.5) +
    theme(legend.position = "bottom") +
    facet_grid(rows = vars(location),
               cols = vars(scenario_id),
               scales = "free") +
    theme_bw() +
    theme(legend.position = "bottom")
}

# plot samples vs data ---------------------------
plot_samples <- function(results,
                         exclude_future = FALSE) {
  if (exclude_future) {
    results <- results |>
      filter(target_end_date <= Sys.Date())
  }
  results |>
    mutate(model_sample = paste0(model, sample)) |>
    ggplot(aes(x = target_end_date)) +
    # geom_point(aes(y = value_100k, col = model_sample), alpha = 0.5) +
    geom_line(aes(y = value_100k, col = model_sample), alpha = 0.3,
              show.legend = FALSE) +
    geom_point(aes(y = obs_100k), col = "black") +
    geom_line(aes(y = obs_100k), col = "black") +
    # scale_y_continuous(limits = c(0,1000)) +
    facet_grid(cols = vars(scenario_id),
               rows = vars(location),
               scales = "free_y") +
    labs(x = NULL, y = "Weekly deaths/100k") +
    theme_bw()
}

if (interactive) {
  # PLOT all samples
  plot_samples(results = results,
               exclude_future = F)
}

# Plot filtering by MAE ----------------------------
# which are the most predictive samples across all targets / all locations?

# join MAE to results
results <- left_join(results, mae,
                     by = c("location",
                            "target_variable", "scenario_id",
                            "model", "sample"))

if (interactive) {
  # lowest % MAE
  threshold <- 0.01

  # find threshold MAE per location
  best_mae_samples <- results |>
    group_by(location) |>  # by location but not by scenario
    mutate(mae_threshold = quantile(mae, threshold)) |>
    filter(mae <= mae_threshold)

  # PLOT only best-scoring samples
  plot_samples(results = best_mae_samples,
               exclude_future = F)
}

# weight by MAE ----------------------------
weights <- results |>
  # exclude MAE over 1 (ie samples with mean errors > 1/100k)
  # filter(mae <= 1) |>
  # take inverse
  mutate(inv_mae = 1/mae) |>
  # weights should be in groups: location, target date,
  #  sample
  group_by(target_end_date,
           location, target_variable) |>
  # create weights
  mutate(sum_inv_mae = sum(inv_mae, na.rm = TRUE),
         weight = inv_mae / sum_inv_mae)

# Use weights to summarise set of projected values
results_weighted <- weights |>
  summarise(weighted_value = sum(value * weight),
            weighted_value_100k = sum(value_100k * weight))

# Add observations (for plotting)
obs <- results |>
  select(target_end_date, location, obs, obs_100k) |>
  distinct() |>
  tidyr::drop_na()

results_weighted <- left_join(results_weighted, obs,
                      by = c("location", "target_end_date"))

# PLOT weighted ensemble projection
results_weighted |>
  rename("Observed" = obs_100k, "Data-weighted pojection" = weighted_value_100k) |>
  tidyr::pivot_longer(cols = c("Observed",
                               "Data-weighted pojection"),
                      names_to = "Type", values_to = "value") |>
  ggplot(aes(x = target_end_date,
             y = value,
             col = Type), alpha = 0.5) +
  geom_line() +
  geom_point() +
  facet_grid(rows = vars(location),
             scales = "free") +
  labs(x = NULL,
       y = NULL,
       subtitle = "Projected weekly incident deaths per 100k") +
  scale_color_brewer(type = "qual", palette = 2) +
  theme_bw() +
  theme(legend.position = "bottom")


# add uncertainty --------------------------------
# quantiles of the original samples?
# leave one out for each observed data point?
#










