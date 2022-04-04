# Get results
library(here)
library(dplyr)
library(purrr)
library(readr)
source(here("code", "load", "scenarios.R"))
source(here("code", "summarise", "plot_scenarios.R"))

models <- list.dirs(here("data-processed"), full.names = FALSE)
models <- models[grepl(".", models)]
results <- map_dfr(.x = models,
                    ~ read_csv(here("data-processed", .x,
                                    paste0(scenarios$round_0$origin_date,
                                           "-", .x, ".csv"))) %>%
                      mutate(model = .x)) %>%
  mutate(scenario = recode(scenario_id,
                           !!!scenarios$round_0$scenario_labels))







