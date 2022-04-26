# Get results
library(here)
library(dplyr)
library(purrr)
library(readr)

# get scenario metadata
source(here("code", "load", "scenarios.R"))
# get model projections
source(here("code", "load", "load_local_results.R"))
# get plotting function
source(here("code", "load", "plot_scenarios.R"))

# Get results -------------------------------------------------------------
results <- load_local_results(round = 0)

# Plot by scenario --------------------------------------------------------
cross_scenario_deaths <- plot_scenarios(results,
                                        scenarios$round_0$scenario_caption,
                                     target_variable = "inc death",
                                     columns = "scenario")
ggsave(here("reports", "round-0", "cross-scenario-deaths.png"),
       height = 35, width = 10)


cross_scenario_cases <- plot_scenarios(results,
                                       scenarios$round_0$scenario_caption,
                                     target_variable = "inc case",
                                     columns = "scenario")
ggsave(here("reports", "round-0", "cross-scenario-cases.png"),
       height = 35, width = 10)

# Plot by model --------------------------------------------------------
cross_model_deaths <- plot_scenarios(results,
                                     scenarios$round_0$scenario_caption,
                                        target_variable = "inc death",
                                        columns = "model")
ggsave(here("reports", "round-0", "cross-model-deaths.png"),
       height = 35, width = 10)

cross_model_cases <- plot_scenarios(results,
                                    scenarios$round_0$scenario_caption,
                                       target_variable = "inc case",
                                       columns = "model")
ggsave(here("reports", "round-0", "cross-model-cases.png"),
       height = 35, width = 10)





