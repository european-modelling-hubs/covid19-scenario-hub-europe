# Get all submitted csv files by Round
library(here)
library(dplyr)
library(purrr)
library(lubridate)
library(covidHubUtils)
library(arrow)
library(curl)
library(readr)

load_results <- function(local = FALSE,
                         round = 1,
                         n_model_min = 2) {

  # Load scenario data --------------------------------------

  if (local) {
    source(here("code", "load-from-local.R"))
    results <- load_local_results(round = round)
  } else { # Load from remote host
    # get scenario metadata
    try(source("https://raw.githubusercontent.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe-website/main/code/load/scenarios.R"))
    # get round path
    data_path <- tempfile(fileext = ".parquet")
    url <- paste0("https://github.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/releases/download/round",
                  round, "/round", round,
                  ".parquet")
    # Load from parquet storage
    try(curl::curl_download(url, data_path))
    results <- try(arrow::read_parquet(data_path))

    # results loaded from parquet seem to have mixed target end dates
    #    between models - fix this
    results <- results |>
      mutate(horizon = as.numeric(substr(horizon, 1, 2)),
             target_end_date = scenarios[[paste0("round-", round)]][["origin_date"]] +
               lubridate::weeks(horizon) - lubridate::days(1))
  }

  # -------------------------------------------------------------------------
  # models:
  #   In round 1, USC submitted 2 sets of results from the same model
  #    ("USC-SIkJalpha"), using only new data ~3 weeks apart ("USC-SIkJalpha_update").
  #    Note the parquet version only includes the first of these.
  #    If loading from local, use only "USC-SIkJalpha"
  if (round == 1) {
    models <- distinct(results, model) |>
      filter(grepl("^USC-SIkJalpha", model))
    if (nrow(models) > 1) {
      results <- filter(results,
                        !grepl("^USC-SIkJalpha_update$", model))
    }
  }

  # Filter results to countries with multiple models
  multi_model_targets <- distinct(results,
                                  model, location, target_variable) %>%
    group_by(location, target_variable) %>%
    tally() %>%
    filter(n >= n_model_min) |>
    select(-n)
  results <- left_join(multi_model_targets, results)

  # Add values per 100k population
  pop <- read_csv(here("data-locations", "locations_eu.csv"),
                  show_col_types = FALSE) %>%
    select(location, population)

  results <- left_join(results, pop, by = "location") %>%
    mutate(value_100k = value / population * 100000) %>%
    select(-population)

  # Load truth data ------------------------------------------------------
  if (local) {
    # load a local copy
    obs <- read_csv(here("code", "obs.csv"))
  } else {
    obs <- try(load_truth(
      truth_source = "JHU",
      temporal_resolution = "weekly",
      hub = "ECDC"
    ))
    # and save
    write_csv(obs, here("code", "obs.csv"))
  }

  obs <- obs |>
    mutate(obs = value,
           obs_100k = obs / population * 100000) |>
    select(-model, -value, -population) |>
    filter(target_end_date >= min(results$target_end_date))

  # join results & obs -----------------------------------------
  results <- left_join(results, obs,
                       by = c("location", "target_variable",
                              "target_end_date"))

  return(results)

}
