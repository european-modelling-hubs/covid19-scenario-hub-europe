# Format raw sample results, by
# - filtering to a minimum of 3 models per target,
# - including observed data points
# - including values per 100k population
library(here)
library(dplyr)
library(lubridate)
library(covidHubUtils)
# Example:
# source(here("analysis", "import-results.R"))
# results <- import_results(round = round, local = local)
# results <- format_results()

format_results <- function(results,
                           max_obs_date,
                           n_model_min = 3,
                           local = FALSE) {

  # Remove targets with <3 models  ------------------
  results <- anti_join(results,
                       results |>
                         group_by(round, location, scenario_id,
                                  target_end_date, target_variable) |>
                         summarise(models = n_distinct(model),
                                   .groups = "drop") |>
                         filter(models < n_model_min),
                       by = c("round", "location", "scenario_id",
                              "target_end_date", "target_variable")) |>
    ungroup()

  # Add observed data ------------------------------------------------------
  if (local) { # load a local copy
    obs <- read_csv(here("analysis", "data", "obs.csv"))
  } else {
    obs <- load_truth(
      truth_source = "JHU",
      temporal_resolution = "weekly",
      hub = "ECDC")
    write_csv(obs, here("analysis", "data", "obs.csv"))
  }

  if (missing(max_obs_date)) {
    max_obs_date <- max(results$target_end_date)
  }

  obs <- obs |>
    filter(between(target_end_date,
                   min(results$target_end_date),
                   max_obs_date)) |>
    rename(obs = value) |>
    select(-model)

  results <- left_join(results,
                       obs |>
                         select(obs,
                                location, target_variable, target_end_date),
                       by = c("location", "target_variable", "target_end_date"))

  # Add values per 100k population --------------------------------------
  results <- results |>
    # get population size (from obs dataset)
    left_join(obs |>
                group_by(location, location_name, target_variable) |>
                filter(target_end_date == min(target_end_date)) |>
                select(location, target_variable,
                       location_name, population),
              by = c("location", "target_variable")) |>
    # take value per 100k
    mutate(value_100k = value / population * 100000,
           obs_100k = obs / population * 100000)

  return(results)
}
