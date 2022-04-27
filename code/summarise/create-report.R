# Create plots and report
library(here)
library(dplyr)
library(purrr)
library(readr)
# get scenario metadata
source(here("code", "load", "scenarios.R"))
# get model projections
source(here("code", "load", "load_local_results.R"))

# Set round
round <- 0

# Get results
scenario_round <- scenarios[[paste0("round_", 0)]]
results <- load_local_results(round = round)

# Create reporting directory
report_dir <- paste0(here("reports"), "/round-", round)
if(!dir.exists(report_dir)){ dir.create(report_dir) }

# Create plots
source(here("code", "summarise", "create-plots.R"))

# Render report ----------------------------------------------------------
rmarkdown::render(here("code", "summarise", "results.Rmd"),
                  output_file = here(report_dir, "report.html"),
                  params = list("round" = round))
