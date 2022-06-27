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
round <- purrr::transpose(scenarios[!grepl("targets", names(scenarios))])
round <- max(unlist(round$round))

# Render report ----------------------------------------------------------
rmarkdown::render(here("code", "summarise", "results.Rmd"),
                  output_file = here("reports", paste0("report_round", round, ".html")),
                  output_options = list(lib_dir = here("reports", "site_libs")),
                  params = list("round" = round))
