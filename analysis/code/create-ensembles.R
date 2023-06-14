# Create ensembles from raw samples and from quantiles of each model
library(here)
library(dplyr)
source(here("analysis", "code", "score-samples.R"))

# Example:
# results <- load_results(round = 1, n_model_min = 3, local = TRUE)
# ensembles <- create_ensembles(results, c(0.01, 0.5, 0.99))

create_ensembles <- function(results,
                             truncate_weeks = 2,
                             quantiles = c(0.01, 0.25, 0.5, 0.75, 0.99)) {

  # Create simple ensemble of samples -----
  ensemble_samples <- results |>
    group_by(round, location, target_variable, target_end_date, scenario_id) |>
    summarise(
      n = n(),
      value = quantile(value_100k, quantiles),
      quantile = paste0("q", quantiles),
      model = "Samples",
      .groups = "drop"
    )

  # Ensemble of samples weighted by predictive accuracy -----
  ensemble_weighted <- results |>
    # ---- score
    score_samples(truncate_weeks = truncate_weeks) |>
    # ---- ensemble
    group_by(round, location, target_variable, target_end_date) |>
    summarise(
      value = cNORM::weighted.quantile.harrell.davis(x = value_100k,
                                                     probs = quantiles,
                                                     weights = weight),
      quantile = paste0("q", quantiles),
      model = paste0("Samples"),
      scenario_id = "Weighted",
      .groups = "drop"
    )

  # Create ensemble of quantile-summarised-samples -----
  # ----- take quantiles from models
  ensemble_quantile <- results |>
    group_by(round, location, target_variable, target_end_date, scenario_id,
             model) |>
    summarise(
      value = quantile(value_100k, quantiles),
      quantile = paste0("q", quantiles),
      .groups = "drop"
    ) |>
    # ----- take median of each quantile
    group_by(round, location, target_variable, target_end_date, scenario_id,
             quantile) |>
    summarise(
      n = n(),
      value = median(value),
      model = "Quantiles",
      .groups = "drop"
    )

  # Combine -----
  ensembles <- bind_rows(ensemble_quantile, ensemble_samples, ensemble_weighted)

  return(ensembles)
}
