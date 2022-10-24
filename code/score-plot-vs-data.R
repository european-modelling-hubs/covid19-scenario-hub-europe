library(here)
library(ggplot2)
source(here("code", "load.R"))

# load results - only inc death target
results <- load_results(local = FALSE,
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
# plot by frequency
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

# by sample
mae |>
  ggplot(aes(x = sample, col = model)) +
  geom_point(aes(y = mae), alpha = 0.5) +
  theme(legend.position = "bottom") +
  facet_grid(rows = vars(location),
             cols = vars(scenario_id),
             scales = "free") +
  theme_bw() +
  theme(legend.position = "bottom")

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

# all samples
plot_samples(results = results,
             exclude_future = F)


# Plot filtering by MAE ----------------------------
# which are the most predictive samples across all targets / all locations?

# join MAE to results
results <- left_join(results, mae,
                     by = c("location",
                            "target_variable", "scenario_id",
                            "model", "sample"))
# lowest 1% MAE
threshold <- 0.01
best_mae_samples <- results |>
  group_by(location) |>  # by location but not by scenario
  mutate(mae_threshold = quantile(mae, threshold)) |>
  filter(mae <= mae_threshold)

plot_samples(results = best_mae_samples,
             exclude_future = T)
# how many samples in that 1%
top_one_pc <- best_mae_samples |>
  distinct(model, location, scenario_id, sample)




