library(here)
library(dplyr)
library(tidyr)
library(purrr)
library(cNORM)
library(lubridate)

# ----- Score samples by MAE
score_samples <- function(results,
                          n_weeks = "all") {

  if (n_weeks == "all") {
    n_weeks <- length(unique(results$target_end_date))
  }
  last_data_point <- min(results$target_end_date) + (7 * n_weeks)

  # ----- Score
  mae <- results |>
    filter(
      # score against observations
      !is.na(obs) &
        # score against sub-set of data
        target_end_date <= last_data_point) |>
    # absolute error
    mutate(ae = abs(value_100k - obs_100k)) |>
    # mean absolute error
    group_by(location, target_variable,
             model, sample, scenario_id) |>
    summarise(mae = mean(ae),
              .groups = "drop")

  # join MAE to results
  results <- left_join(results, mae,
                       by = c("location", "target_variable", "scenario_id",
                              "model", "sample"))

  # ----- Create MAE weights
  results_with_weights <- results |>
    # take inverse
    mutate(inv_mae = 1/mae) |>
    # weights for each sample should be grouped by target, but not scenario
    group_by(target_end_date,
             location, target_variable) |>
    # create weights
    mutate(sum_inv_mae = sum(inv_mae, na.rm = TRUE),
           weight = inv_mae / sum_inv_mae)

  return(results_with_weights)

}
