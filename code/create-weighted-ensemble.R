library(here)
library(dplyr)
library(tidyr)
library(purrr)
library(cNORM)
library(ggplot2)
source(here("code", "load.R"))

# Set up: Functions for handling samples --------------------
#
# ----- Score samples by MAE
score_samples <- function(results) {
  # ----- Score
  mae <- results |>
    filter(!is.na(obs)) |>
    mutate(ae = abs(value_100k - obs_100k)) |>
    group_by(location, target_variable,
             model, sample, scenario_id) |>
    summarise(mae = mean(ae))

  # join MAE to results
  results <- left_join(results, mae,
                       by = c("location", "target_variable", "scenario_id",
                              "model", "sample"))

  # ----- Create MAE weights
  results_with_weights <- results |>
    # take inverse
    mutate(inv_mae = 1/mae) |>
    # weights for each sample should be grouped by target
    group_by(target_end_date,
             location, target_variable) |>
    # create weights
    mutate(sum_inv_mae = sum(inv_mae, na.rm = TRUE),
           weight = inv_mae / sum_inv_mae)

  return(results_with_weights)

}

# ----- Create ensembles
create_ensemble <- function(results_with_weights,
                            quantiles = c(0.05, 0.25, 0.5, 0.75, 0.95)) {
  ensemble <- map_dfr(.x = quantiles,
                      ~ results_with_weights |>
                        group_by(location, target_variable, target_end_date) |>
                        summarise(quantile = .x,
                                  # Unweighted
                                  unweighted = quantile(x = value_100k, probs = .x),
                                  # Weighted quantiles
                                  weighted = cNORM::weighted.quantile.harrell.davis(x = value_100k,
                                                                                    probs = .x,
                                                                                    weight = weight),
                                  .groups = "drop"))

  return(ensemble)
}

# Run: Load, score, ensemble, and plot --------------------
# ----- Load all samples
results <- load_results(local = TRUE,
                        round = 1,
                        n_model_min = 2) |>
  # only inc death
  filter(target_variable == "inc death")

# ----- Score and create ensemble
results_with_weights <- score_samples(results)
ensemble <- create_ensemble(results_with_weights)

# ----- Reshape data for plotting
plot_data <- ensemble |>
  pivot_longer(cols = ends_with(c("weighted")),
               names_to = "method") |>
  pivot_wider(names_from = quantile, names_prefix = "q") |>
  # add observations for plotting
  left_join(distinct(results,
                     location, target_variable,
                     target_end_date, obs_100k))

# ----- Plot
plot <- plot_data |>
  ggplot(aes(x = target_end_date)) +
  # ----- Geoms
  # 95% quantiles
  geom_line(aes(y = q0.95, col = method),
            alpha = 0.1) +
  geom_line(aes(y = q0.05, col = method),
            alpha = 0.1) +
  geom_ribbon(aes(ymin = q0.05, ymax = q0.95,
                  fill = method), alpha = 0.1) +
  # 50%
  geom_line(aes(y = q0.75, col = method),
            alpha = 0.2) +
  geom_line(aes(y = q0.25, col = method),
            alpha = 0.2) +
  geom_ribbon(aes(ymin = q0.25, ymax = q0.75,
                  fill = method), alpha = 0.2) +
  # median
  geom_line(aes(y = q0.5, col = method),
            alpha = 0.3, size = 1) +
  # observed data as points
  geom_point(aes(y = obs_100k), size = 1) +
  # ----- Structure
  scale_colour_brewer(type = "qual", palette = 2, direction = -1,
                      aesthetics = c("col", "fill")) +
  facet_grid(rows = vars(location),
             scales = "free") +
  labs(x = NULL, y = "Incident deaths per 100,000",
       caption = "Showing median (line), 50% and 95% quantiles") +
  theme_bw() +
  theme(legend.position = "bottom")

plot
