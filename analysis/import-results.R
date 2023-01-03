# Get all submitted csv files by Round
library(readr)
library(stringr)
library(purrr)
library(here)
library(dplyr)
library(lubridate)
library(arrow)
library(curl)
library(readr)

# Get results from local repo -----
import_results <- function(round = 1,
                           local = TRUE) {

  if (local) {
    # get scenarios metadata
    scenarios <- read_rds(here("analysis", "data", "scenarios.rds"))

    # get csv paths
    model_results <- list.files(here("data-processed"),
                                full.names = TRUE, recursive = TRUE)
    model_results <- model_results[grepl(".csv", model_results)]

    # get model date and name
    models <- tibble(file = model_results) |>
      mutate(date = as.Date(str_extract(file,
                                        "2022-[:digit:][:digit:]-[:digit:][:digit:]")),
             model = str_remove(file, here("data-processed")),
             model = str_extract(model, "\\/(.+)\\/"),
             model = str_remove_all(model, "\\/"))

    # keep only files within round specific dates
    origin_date = scenarios[[paste0("round-", round)]][["origin_date"]]
    window_end = scenarios[[paste0("round-", round)]][["submission_window_end"]]
    valid_dates <- seq.Date(from = as.Date(origin_date),
                            to = as.Date(window_end), by = 1)
    models <- filter(models, date %in% valid_dates)

    # read csv
    safely_read <- safely(~ read_csv(., show_col_types = FALSE))
    results <- map(.x = models$file,
                   ~ safely_read(.x))
    names(results) <- models$model
    results <- transpose(results)
    results <- bind_rows(results$result, .id = "model") |>
      mutate(round = round)

    # add dates
    results <- results |>
      mutate(horizon = as.numeric(str_remove(horizon, " wk")),
             target_end_date = origin_date + lubridate::weeks(horizon) - 1)

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

  } else { # Get from remote source -----

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
    results <- results |>
      mutate(horizon = as.numeric(substr(horizon, 1, 2)),
             target_end_date = as.Date(scenarios[[paste0("round-", !!round)]][["origin_date"]]) +
               lubridate::weeks(horizon) - lubridate::days(1),
             round = round)
  }

  return(results)
}
