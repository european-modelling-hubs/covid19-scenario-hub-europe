# Scratchpad all in one script

interactive <- FALSE

library(here)
library(ggplot2)
library(tidyr)
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
                            "target_variable",
                            "scenario_id",
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

# weight by MAE ---------------------------------------------
results <- results |>
  # take inverse
  mutate(inv_mae = 1/mae) |>
  # weights should be in groups:
  #   location, target date
  group_by(target_end_date,
           location, target_variable) |>
  # create weights
  mutate(sum_inv_mae = sum(inv_mae, na.rm = TRUE),
         weight = inv_mae / sum_inv_mae)

# with uncertainty -------------------------------------------
# quantiles of the weighted samples
library(reldist)

results_unweighted <- results |>
  group_by(location, target_end_date) |>
  summarise(
    ensemble = "unweighted quantiles",
    q05 = quantile(value_100k, 0.05),
    q25 = quantile(value_100k, 0.25),
    q50 = quantile(value_100k, 0.5),
    q75 = quantile(value_100k, 0.75),
    q95 = quantile(value_100k, 0.95))

# weighted quantiles
results_weighted <- results |>
  group_by(location, target_end_date) |>
  summarise(
    ensemble = "weighted quantiles",
    q05 = wtd.quantile(x = value_100k, q = 0.05, weight = weight),
    q25 = wtd.quantile(x = value_100k, q = 0.25, weight = weight),
    q50 = wtd.quantile(x = value_100k, q = 0.5, weight = weight),
    q75 = wtd.quantile(x = value_100k, q = 0.75, weight = weight),
    q95 = wtd.quantile(x = value_100k, q = 0.95, weight = weight))

# join
results_plot <- bind_rows(results_weighted,
                          results_unweighted
                          ) |>
  left_join(distinct(results,
                     location, target_variable,
                     target_end_date, obs_100k))

# Plot projection ----------------------------------
results_plot |>
  ggplot(aes(x = target_end_date)) +
  # geom_ribbon(aes(ymin = q05, ymax = q95,
  #                 fill = ensemble), alpha = 0.2) +
  geom_ribbon(aes(ymin = q25, ymax = q75,
                  fill = ensemble), alpha = 0.3) +
  geom_line(aes(y = q50, col = ensemble),
            alpha = 0.3,
            size = 1) +
  geom_point(aes(y = obs_100k), size = 0.9) +
  facet_grid(rows = vars(location),
             scales = "free") +
  labs(x = NULL, y = "Incident deaths per 100,000",
       caption = "Projections show median (line), 0.25-0.75 quantiles (shaded)") +
  scale_color_brewer(type = "qual", palette = 2,
                     aesthetics = c("col", "fill")) +
  theme_bw() +
  theme(legend.position = "bottom")






