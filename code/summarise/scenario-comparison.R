# Create all plots
library(dplyr)
library(ggplot2)
library(here)
library(covidHubUtils)
library(patchwork)

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

results_1_cases <- filter(results_multi_country,
                             grepl("A|B", scenario_id))
scenario_1_cases <- plot_scenarios(results_1_cases,
                                        truth,
                                        target_variable = "inc case",
                                        columns = "scenario",
                                        model_colours = palette$models,
                                        scenario_colours = palette$scenarios)

results_2_cases <- filter(results_multi_country,
                            grepl("C|D", scenario_id))
scenario_2_cases <- plot_scenarios(results_2_cases,
                                      truth,
                                      target_variable = "inc case",
                                      columns = "scenario",
                                      model_colours = palette$models,
                                      scenario_colours = palette$scenarios)

scenario_1_cases +
  scenario_2_cases +
  plot_layout(nrow = 2,
              guides = "auto")

# ggsave(filename = "summary-plot.png", height = 7, width = 12)








