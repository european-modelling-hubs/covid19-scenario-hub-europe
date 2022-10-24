library(here)
library(ggplot2)
source(here("code", "load.R"))

results <- load_results(local = FALSE,
                        round = 2,
                        n_model_min = 3)

## Look only at inc death target
results_all <- split(results, results$target_variable)
results <- results_all[["inc death"]]

# score ------------------------------
mae <- results |>
  filter(!is.na(obs)) |>
  mutate(ae = abs(value_100k - obs_100k)) |>
  group_by(location, target_variable,
           model, sample, scenario_id) |>
  summarise(mae = mean(ae))

# join MAE to results
results <- left_join(results, mae,
                     by = c("location",
                            "target_variable", "scenario_id",
                            "model", "sample"))

# explore MAE
# quantile(mae$mae, c(0, 0.25, 0.5, 0.75, 1))
# cases: top 25% MAE scores are off by <=10/100k
# deaths: 0.17/100k

# Plot mae
mae |>
  ggplot(aes(x = sample, col = model)) +
  geom_point(aes(y = mae), alpha = 0.5) +
  theme(legend.position = "bottom") +
  facet_grid(rows = vars(location),
             cols = vars(scenario_id),
             scales = "free") +
  theme_bw() +
  theme(legend.position = "bottom")

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


# plot samples vs data ---------------------------
plot_samples <- function(results,
                         exclude_future = FALSE) {
  if (exclude_future) {
    results <- results |>
      filter(target_end_date <= Sys.Date())
  }
  results |>
    mutate(model_sample = paste0(model, sample),
           inv_mae = (1/mae)/1000) |>
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


# plots -------------------

# all samples
plot_samples(results = results,
             exclude_future = T)

# what are the most predictive samples across all targets / all locations?

# lowest MAE
threshold <- quantile(mae$mae, 0.01)
best_mae_samples <- results |>
  group_by(location) |>  # not by scenario
  mutate(mae_threshold = quantile(mae, threshold)) |>
  filter(mae <= mae_threshold)

plot_samples(results = best_mae_samples,
             exclude_future = T)

top_one_pc <- best_mae_samples |>
  distinct(model, location, scenario_id, sample)




