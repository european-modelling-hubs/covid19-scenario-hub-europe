# Create plots and report
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

# Set round
round <- 0


# Set up ------------------------------------------------------------------

# Get results
results <- load_local_results(round = round)

# Create reporting directory
report_dir <- paste0(here("reports"), "/round-", round)
if(!dir.exists(report_dir)){
  dir.create(report_dir)
}

scenario_round <- scenarios[[paste0("round_", 0)]]

# Plot by scenario --------------------------------------------------------
cross_scenario_deaths <- plot_scenarios(results,
                                        scenario_round$scenario_caption,
                                        target_variable = "inc death",
                                        columns = "scenario")
ggsave(here(report_dir, "cross-scenario-deaths.png"),
       height = 35, width = 10)


cross_scenario_cases <- plot_scenarios(results,
                                       scenario_round$scenario_caption,
                                       target_variable = "inc case",
                                       columns = "scenario")
ggsave(here(report_dir, "cross-scenario-cases.png"),
       height = 35, width = 10)

# Plot by model --------------------------------------------------------
cross_model_deaths <- plot_scenarios(results,
                                     scenario_round$scenario_caption,
                                     target_variable = "inc death",
                                     columns = "model")
ggsave(here(report_dir, "cross-model-deaths.png"),
       height = 35, width = 10)

cross_model_cases <- plot_scenarios(results,
                                    scenario_round$scenario_caption,
                                    target_variable = "inc case",
                                    columns = "model")
ggsave(here(report_dir, "cross-model-cases.png"),
       height = 35, width = 10)


# Render report ----------------------------------------------------------
rmarkdown::render(here("code", "summarise", "results.Rmd"),
                  output_file = here(report_dir, "report.html"),
                  params = list("round" = round))
