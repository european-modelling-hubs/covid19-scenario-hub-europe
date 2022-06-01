# Get all submitted csv files, optionally by Round
library(here)
library(stringr)
library(dplyr)
library(purrr)
library(readr)
source(here("code", "load", "scenarios.R"))

load_local_results <- function(round = NULL, subdir = "data-processed") {

  # get csv paths
  model_results <- list.files(here(subdir),
                              full.names = TRUE, recursive = TRUE)
  model_results <- model_results[grepl(".csv", model_results)]

  # name each csv by model
  model_names <- gsub(here(subdir), "", model_results)
  model_names <- str_extract(model_names, "\\/(.+)\\/")
  model_names <- str_remove_all(model_names, "\\/")
  names(model_results) <- model_names

  # get results by model
  results <- imap_dfr(.x = model_results,
                      ~ read_csv(.x) %>%
                        mutate(model = .y) %>%
                        filter(!is.na(value)))

  # round specific results
  if (!is.null(round)) {
    round_number <- paste0("round_", round)
    results <- results %>%
      filter(between(origin_date,
                     left = scenarios[[round_number]][["origin_date"]],
                     right = scenarios[[round_number]][["submission_window_end"]])) %>%
      mutate(scenario_label = recode(scenario_id,
                               !!!scenarios[[round_number]][["scenario_labels"]]))
  }

  return(results)
}
