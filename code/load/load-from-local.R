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
scenario_caption <- scenarios$round_0$scenario_caption

# plot --------------------------------------------------------------------
# By scenario
cross_scenario_deaths <- plot_scenarios(results,
                                     scenario_caption,
                                     target_variable = "inc death",
                                     columns = "scenario")
ggsave(here("reports", "round-0", "cross-scenario-deaths.png"),
       height = 35, width = 10)

cross_scenario_cases <- plot_scenarios(results,
                                     scenario_caption,
                                     target_variable = "inc case",
                                     columns = "scenario")
ggsave(here("reports", "round-0", "cross-scenario-cases.png"),
       height = 35, width = 10)

# By model
cross_model_deaths <- plot_scenarios(results,
                                        scenario_caption,
                                        target_variable = "inc death",
                                        columns = "model")
ggsave(here("reports", "round-0", "cross-model-deaths.png"),
       height = 35, width = 10)

cross_model_cases <- plot_scenarios(results,
                                       scenario_caption,
                                       target_variable = "inc case",
                                       columns = "model")
ggsave(here("reports", "round-0", "cross-model-cases.png"),
       height = 35, width = 10)


# Data summaries ----------------------------------------------------------

# How many peaks?
# Average peak value?
# Highest peak value?
# Time from minima to maxima?







