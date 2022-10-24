library(readr)
library(stringr)
library(purrr)
library(here)
library(dplyr)
library(lubridate)

# Load results from local repo
load_local_results <- function(round = NULL, subdir = NULL) {

  if (is.null(subdir)) {subdir <- "data-processed"}

  # load a local copy of scenarios metadata
  scenarios <- read_rds(here("code", "20221021-scenarios.rds"))

  # get csv paths
  model_results <- list.files(here(subdir),
                              full.names = TRUE, recursive = TRUE)
  model_results <- model_results[grepl(".csv", model_results)]

  # get model date and name
  models <- tibble(file = model_results) |>
    mutate(date = as.Date(str_extract(file,
                                      "2022-[:digit:][:digit:]-[:digit:][:digit:]")),
           model = str_remove(file, here(subdir)),
           model = str_extract(model, "\\/(.+)\\/"),
           model = str_remove_all(model, "\\/"))

  # keep only files within round specific dates
  origin_date = scenarios[[paste0("round-", round)]][["origin_date"]]
  window_end = scenarios[[paste0("round-", round)]][["submission_window_end"]]
  valid_dates <- seq.Date(from = origin_date, to = window_end, by = 1)
  models <- filter(models, date %in% valid_dates)

  # read csv
  safely_read <- safely(read_csv, .)
  results <- map(.x = models$file,
                 ~ safely_read(.x))
  names(results) <- models$model
  results <- transpose(results)
  results <- bind_rows(results$result, .id = "model") |>
    mutate(round = round)

  # Standardise values per 100k population
  pop <- read_csv(here("data-locations", "locations_eu.csv"),
                  show_col_types = FALSE) %>%
    select(location, population)
  results <- left_join(results, pop, by = "location") %>%
    mutate(value_100k = value / population * 100000) %>%
    select(-population)

  # add dates
  results <- results |>
    mutate(origin_date = origin_date,
           horizon = as.numeric(str_remove(horizon, " wk")),
           target_end_date = origin_date + lubridate::weeks(horizon) - 1)

  return(results)
}
