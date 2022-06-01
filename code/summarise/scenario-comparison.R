# Create all plots
library(dplyr)
library(ggplot2)
library(here)
library(covidHubUtils)
# get scenario metadata
source(here("code", "load", "scenarios.R"))
# get model projections
source(here("code", "load", "load_local_results.R"))
# get plotting colours
source(here("code", "load", "plot_palettes.R"))
# get plotting function
source(here("code", "load", "plot_scenarios.R"))

# Set round or pass through environment
round <- 0

# Set up ------------------------------------------------------------------
# Get results
results <- load_local_results(round = round)
## Get data
truth <- load_truth(
  truth_source = "JHU",
  temporal_resolution = "weekly",
  hub = "ECDC"
) %>%
  select(-model)

# Create reporting directory
report_dir <- paste0(here("reports"), "/round-", round)
if(!dir.exists(report_dir)){
  dir.create(report_dir)
}
scenario_round <- scenarios[[paste0("round_", round)]]

# create consistent model and scenario colour palettes
palette <- plot_palettes(results)

# Plot by scenario --------------------------------------------------------
multi_country <- distinct(results, model, location) %>%
  group_by(location) %>%
  tally() %>%
  filter(n > 2) %>%
  pull(location)

results_multi_country <- filter(results, location %in% multi_country)

results_a_b_cases <- filter(results_multi_country,
                             scenario_id %in% c("A-2022-02-25",
                                                "B-2022-02-25"))
scenario_a_b_cases <- plot_scenarios(results_a_b_cases,
                                        truth,
                                        scenario_caption = NULL,
                                        target_variable = "inc case",
                                        columns = "scenario",
                                        model_colours = palette$models,
                                        scenario_colours = palette$scenarios)

ggsave(here(report_dir, "scenario-a-b-cases.png"),
      plot = scenario_a_b_cases,
       height = 5, width = 8)

results_c_d_cases <- filter(results_multi_country,
                             scenario_id %in% c("C-2022-02-25",
                                                "D-2022-02-25"))
scenario_c_d_cases <- plot_scenarios(results_c_d_cases,
                                      truth,
                                      scenario_caption = NULL,
                                      target_variable = "inc case",
                                      columns = "scenario",
                                      model_colours = palette$models,
                                      scenario_colours = palette$scenarios)

ggsave(here(report_dir, "scenario-c-d-cases.png"),
       plot = scenario_c_d_cases,
       height = 5, width = 8)









