library(ggplot2)
source(here("code", "load.R"))
results <- load_results(local = TRUE)

results_all <- split(results, results$target_variable)

results <- results_all[["inc case"]]

# plot samples and data -----------------
results |>
  # filter scale limits
  filter(target_end_date < Sys.Date()) |>
  mutate(model_sample = paste0(model, sample)) |>
  # plot
  ggplot(aes(x = target_end_date)) +
  geom_point(aes(y = obs_100k)) +
  geom_point(aes(y = value_100k, col = model_sample), alpha = 0.5) +
  geom_line(aes(y = value_100k, col = model_sample), alpha = 0.5) +
  geom_point(aes(y = obs_100k), col = "black") +
  geom_line(aes(y = obs_100k), col = "black") +
  facet_grid(rows = vars(location),
             cols = vars(scenario_id),
             scales = "free") +
  theme(legend.position = "none")

# score -------------------------------------------------------------------
mae <- results |>
  filter(!is.na(obs)) |>
  mutate(ae = abs(value_100k - obs_100k)) |>
  group_by(location, target_variable,
           model, sample, scenario_id) |>
  summarise(mae = mean(ae))

# Plot mae
mae |>
  ggplot(aes(x = sample, col = model)) +
  geom_point(aes(y = mae), alpha = 0.5) +
  facet_wrap("scenario_id") +
  theme(legend.position = "bottom") +
  facet_grid(rows = vars(location),
             cols = vars(scenario_id),
             scales = "free")

# MAE cutoff --------------------------------
# quantile(mae$mae, c(0, 0.25, 0.5, 0.75, 1))
# top 25% MAE scores are off by <=10/100k
results_mae <- left_join(results, mae,
                         by = c("location", "target_variable", "scenario_id",
                                "model", "sample"))

results_mae |>
  # keep best performing samples
  # filter(mae <= 10) |>
  # plot
  mutate(model_sample = paste0(model, sample)) |>
  ggplot(aes(x = target_end_date)) +
  geom_point(aes(y = value_100k, col = model_sample), alpha = 0.5) +
  geom_line(aes(y = value_100k, col = model_sample), alpha = 0.5) +
  geom_point(aes(y = obs_100k), col = "black") +
  geom_line(aes(y = obs_100k), col = "black") +
  scale_x_date(limits = c(min(results$target_end_date)-7,
                          Sys.Date())) +
  scale_y_continuous(limits = c(0,1000)) +
  facet_grid(cols = vars(scenario_id),
             rows = vars(location)) +
  theme_bw() +
  theme(legend.position = "none")

