# Get all submitted csv files, optionally by Round
library(here)
library(stringr)
library(dplyr)
library(purrr)
library(readr)
source(here("code", "load", "scenarios.R"))

load_local_results <- function(round = NULL, subdir = NULL) {

  if (is.null(subdir)) {subdir <- "data-processed"}

  # get csv paths
  model_results <- list.files(here(subdir),
                              full.names = TRUE, recursive = TRUE)
  model_results <- model_results[grepl(".csv", model_results)]

  # name each csv by model
  model_names <- gsub(here(subdir), "", model_results)
  model_names <- str_extract(model_names, "\\/(.+)\\/")
  model_names <- str_remove_all(model_names, "\\/")
  names(model_results) <- model_names
  model_names <- model_names[!is.na(model_names)]

  # get results by model
  results <- imap_dfr(.x = model_results,
                      ~ read_csv(.x, show_col_types = FALSE) %>%
                        mutate(model = .y) %>%
                        filter(!is.na(value)))

  # round specific results
  if (!is.null(round)) {
    # get scenario metadata
    source(here("code", "load", "scenarios.R"))
    round_text <- paste0("round-", round)

    # filter to round specific dates
    results <- results %>%
      filter(between(origin_date,
                     left = scenarios[[round_text]][["origin_date"]],
                     right = scenarios[[round_text]][["submission_window_end"]]))

    # add scenario labels
    results <- results %>%
      mutate(scenario_label = recode(scenario_id,
                                     !!!scenarios[[round_text]][["scenario_labels"]]))

  }

  # Standardise values per 100k population
  pop <- read_csv(here("data-locations", "locations_eu.csv"),
                  show_col_types = FALSE) %>%
    select(location, population)

  results <- left_join(results, pop, by = "location") %>%
    mutate(value_100k = value / population * 100000) %>%
    select(-population)

  return(results)
}
