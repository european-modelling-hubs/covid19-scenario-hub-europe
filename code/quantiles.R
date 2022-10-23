# show difference in interpretation between quantiles and samples
library(ggplot2)
# Set quantile levels
quantile_levels = c(0, 0.05, 0.25, 0.5, 0.75, 0.95, 1)

# Load results
source(here("code", "load.R"))
results_full <- results
results <- results_full |>
  filter(
    #location == "NL" &
           target_variable == "inc case")

# set model_sample as variable
samples <- results |>
  select(scenario_id, location, target_variable, target_end_date,
         obs,
         model, sample, value) |>
  mutate(model_sample = paste0(model, sample))

# Single "Hub ensemble" from all samples ---------------------
# Quantile ensemble across all samples of all models
quantiles <- samples |>
  group_by(scenario_id, location, target_variable, target_end_date) |>
  summarise(value = round(quantile(value, quantile_levels)),
            name = paste0("q", sub("\\.", "_", quantile_levels)),
            .groups = "drop") |>
  pivot_wider(names_from = name)

# plot samples with quantiles overlay
sample_quantiles <- left_join(samples, quantiles,
                     by = c("location", "target_variable",
                            "target_end_date", "scenario_id"))
sample_quantiles |>
  ggplot(aes(x = target_end_date)) +
  geom_point(aes(y = obs), col = "black") +
  geom_line(aes(y = value, col = model_sample), alpha = 0.1) +
  geom_ribbon(aes(ymin = q0_05, ymax = q0_95), alpha = 0.2) +
  geom_ribbon(aes(ymin = q0_25, ymax = q0_75), alpha = 0.4) +
  facet_wrap("scenario_id") +
  theme_bw() +
  theme(legend.position = "none")

# Ensemble from quantiles of models ------------------------------
# Quantiles across all samples for each model
models_quantiles <- samples |>
  group_by(model,
           scenario_id, location, target_variable, target_end_date) |>
  summarise(value = round(quantile(value, quantile_levels)),
            name = paste0("q", sub("\\.", "_", quantile_levels)),
            .groups = "drop") |>
  pivot_wider(names_from = name)

# plot samples with quantiles overlay
sample_model_quantiles <- left_join(samples, models_quantiles,
                              by = c("location", "target_variable",
                                     "target_end_date", "scenario_id",
                                     "model"))
quantiles <- mutate(quantiles,
                    model = "overall")
sample_model_quantiles <- bind_rows(sample_model_quantiles,
                                    quantiles)

sample_model_quantiles |>
  filter(grepl("A", scenario_id)) |>
  ggplot(aes(x = target_end_date)) +
  geom_line(aes(y = value, col = model_sample), alpha = 0.1,
            show.legend = FALSE) +
  geom_ribbon(aes(ymin = q0_05, ymax = q0_95,
                  fill = model), alpha = 0.2) +
  geom_ribbon(aes(ymin = q0_25, ymax = q0_75,
                  fill = model), alpha = 0.4) +
  facet_wrap("scenario_id", scales = "free_y") +
  theme_bw() +
  theme(legend.position = "bottom")


# Compare results from quantiles and samples -------------------------------
