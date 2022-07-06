# Create all plots
library(dplyr)
library(ggplot2)
library(here)
library(covidHubUtils)

# get model projections
source(here("code", "load", "load_local_results.R"))
# get plotting colours
source(here("code", "load", "plot_palettes.R"))
# get plotting function
source(here("code", "load", "plot_scenarios.R"))

# Set round or pass through environment
round <- 1

# Set up ------------------------------------------------------------------
# get scenario metadata
source(here("code", "load", "scenarios.R"))
# load only specific scenario meta-data
scenario_round_metadata <- scenarios[[paste0("round_", round)]]

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

# create consistent model and scenario colour palettes
palette <- plot_palettes(results)

# Plot by scenario --------------------------------------------------------
multi_country <- distinct(results, model, location) %>%
  group_by(location) %>%
  tally() %>%
  filter(n > 2) %>%
  pull(location)

results_multi_country <- filter(results, location %in% multi_country)

results_a_c_cases <- filter(results_multi_country,
                             grepl("A|C", scenario_id))
scenario_a_c_cases <- plot_scenarios(results_a_c_cases,
                                        truth,
                                        target_variable = "inc case",
                                        columns = "scenario",
                                        model_colours = palette$models,
                                        scenario_colours = palette$scenarios)

# ggsave(here(report_dir, "scenario-a-c-cases.png"),
#       plot = scenario_a_b_cases,
#        height = 5, width = 8)

results_b_d_cases <- filter(results_multi_country,
                            grepl("B|D", scenario_id))
scenario_b_d_cases <- plot_scenarios(results_b_d_cases,
                                      truth,
                                      target_variable = "inc case",
                                      columns = "scenario",
                                      model_colours = palette$models,
                                      scenario_colours = palette$scenarios)

# ggsave(here(report_dir, "scenario-c-d-cases.png"),
#        plot = scenario_c_d_cases,
#        height = 5, width = 8)


library(patchwork)

scenario_a_c_cases +
  scenario_b_d_cases +
  plot_layout(nrow = 2, guides = "auto")








