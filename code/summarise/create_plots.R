# Create all plots
library(dplyr)
library(ggplot2)
library(here)
library(covidHubUtils)
library(purrr)
# get scenario metadata
source(here("code", "load", "scenarios.R"))
# get model projections
source(here("code", "load", "load_local_results.R"))
# get plotting colours
source(here("code", "load", "plot_palettes.R"))
# get plotting function
source(here("code", "load", "plot_scenarios.R"))

create_plots <- function(round) {
  # Set up ------------------------------------------------------------------
  # Create reporting directory
  report_dir <- paste0(here("reports"), "/round-", round)
  target_dirs <- gsub("inc ", "", scenarios$targets)
  if(!dir.exists(report_dir)){
    dir.create(report_dir)
    # - create folder for each target
    walk(target_dirs,
         ~ dir.create(here(report_dir, .x)))
    # -- create folder for single-model plots
    walk(target_dirs,
         ~ dir.create(here(report_dir, .x, "models")))
  }
  scenario_round <- scenarios[[paste0("round-", round)]]

  # Get data ------------------------------------------------------------------
  # Get results
  results <- load_local_results(round = round)
  # create consistent model and scenario colour palettes
  palette <- plot_palettes(results,
                           scenario_reds = c("A", "C"),
                           scenario_blues = c("B", "D"))

  ## Get observed
  truth <- load_truth(
    truth_source = "JHU",
    temporal_resolution = "weekly",
    hub = "ECDC"
  ) |>
    select(-model)

  # Plot by scenario --------------------------------------------------------
  walk(scenarios$targets,
       ~ plot_scenarios(results, truth,
                        round = round,
                        target_variable = .x,
                        columns = "scenario",
                        model_colours = palette$models,
                        scenario_colours = palette$scenarios) %>%
         ggsave(plot = .,
                filename = here(report_dir,
                                gsub("inc ", "", .x),
                                "cross-scenario.png"),
                height = length(unique(results$location)) * 1.75,
                width = 15,
                limitsize = FALSE))

  # Plot by model --------------------------------------------------------
  walk(scenarios$targets,
       ~ plot_scenarios(results, truth,
                        round = round,
                        target_variable = .x,
                        columns = "model",
                        model_colours = palette$models,
                        scenario_colours = palette$scenarios) %>%
         ggsave(plot = .,
                filename = here(report_dir,
                                gsub("inc ", "", .x),
                                "cross-model.png"),
                height = length(unique(results$location)) * 1.75,
                width = 15,
                limitsize = FALSE))

  # Individual model plots --------------------------------------------------
  plots_by_model <- walk(results %>%
                          group_by(target_variable, model) %>%
                          group_split(),
                        ~ plot_scenarios(data = .x, truth = truth,
                                         target_variable = unique(.x$target_variable),
                                         columns = "model",
                                         model_colours = palette$models,
                                         scenario_colours = palette$scenarios) %>%
                          ggsave(filename = here(report_dir,
                                                 gsub("inc ", "",
                                                      unique(.x$target_variable)),
                                                 "models",
                                                 paste0(unique(.x$model), ".png")),
                                 width = 10,
                                 height = ifelse(length(unique(.x$location)) > 3, 50,
                                                 ifelse(length(unique(
                                                   .x$location)) > 1, 12, 8)),
                                 limitsize = FALSE))

}
