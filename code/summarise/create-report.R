# Create plots and report
library(here)
library(dplyr)
library(purrr)
library(readr)
# get scenario metadata
source(here("code", "load", "scenarios.R"))
# get model projections
source(here("code", "load", "load_local_results.R"))
# get plots
source(here("code", "summarise", "create_plots.R"))

# Set round
round <- purrr::transpose(scenarios[!grepl("targets", names(scenarios))])
round <- max(unlist(round$round))

# Create plots ------------------------------------------------------------
create_plots(round = round,
             scenario_reds = c("A", "C"),
             scenario_blues = c("B", "D"))

# Render report ----------------------------------------------------------
rmarkdown::render(here("code", "summarise", "results.Rmd"),
                  output_file = here("reports",
                                     paste0("round-", round),
                                     "report.html"),
                  params = list("round" = round))
