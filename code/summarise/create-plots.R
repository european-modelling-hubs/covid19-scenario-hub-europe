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
if (!exists("round")) {round <- 0}

# Set up ------------------------------------------------------------------
# Get results
results <- load_local_results(round = round)
## Get data
truth <- load_truth(
  truth_source = "JHU",
  temporal_resolution = "weekly",
  hub = "ECDC"
) |>
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
cross_scenario_deaths <- plot_scenarios(results,
                                        truth,
                                        scenario_caption = scenario_round$scenario_caption,
                                        target_variable = "inc death",
                                        columns = "scenario",
                                        model_colours = palette$models,
                                        scenario_colours = palette$scenarios)
ggsave(here(report_dir, "cross-scenario-deaths.png"),
       height = 40, width = 15)


cross_scenario_cases <- plot_scenarios(results,
                                       truth,
                                       scenario_caption = scenario_round$scenario_caption,
                                       target_variable = "inc case",
                                       columns = "scenario",
                                       model_colours = palette$models,
                                       scenario_colours = palette$scenarios)
ggsave(here(report_dir, "cross-scenario-cases.png"),
       height = 40, width = 15)

# Plot by model --------------------------------------------------------
cross_model_deaths <- plot_scenarios(results,
                                     truth,
                                     scenario_caption = scenario_round$scenario_caption,
                                     target_variable = "inc death",
                                     columns = "model",
                                     model_colours = palette$models,
                                     scenario_colours = palette$scenarios)
ggsave(here(report_dir, "cross-model-deaths.png"),
       height = 40, width = 15)

cross_model_cases <- plot_scenarios(results,
                                    truth,
                                    scenario_caption = scenario_round$scenario_caption,
                                    target_variable = "inc case",
                                    columns = "model",
                                    model_colours = palette$models,
                                    scenario_colours = palette$scenarios)
ggsave(here(report_dir, "cross-model-cases.png"),
       height = 40, width = 15)


# Individual model plots --------------------------------------------------
results_by_model <- split(results, results$model)
results_by_model <- results %>%
  group_by(target_variable, model)

results_by_model_names <- results_by_model %>%
  distinct(target_variable, model) %>%
  mutate()

results_by_model <- results_by_model %>%
  group_split()

if (!dir.exists(here(report_dir, "inc case"))) {
  dir.create(here(report_dir, "inc case"))
  dir.create(here(report_dir, "inc death"))
}

# Plot
plots_by_model <- map(results_by_model,
                      ~ plot_scenarios(data = .x,
                                       truth = truth,
                                            target_variable = unique(.x$target_variable),
                                            columns = "model",
                                            model_colours = palette$models,
                                            scenario_colours = palette$scenarios) %>%
                        ggsave(filename = here(report_dir,
                                               unique(.x$target_variable),
                                               paste0(unique(.x$model), ".png")),
                               width = 10,
                               height = ifelse(length(unique(.x$location)) > 3, 50,
                                               ifelse(length(unique(.x$location)) > 1,
                                                      12, 8)),
                               limitsize = FALSE))

