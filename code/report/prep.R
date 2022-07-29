# Load data for reporting

# Packages
library(here)
library(dplyr)
library(ggplot2)
library(purrr)
library(covidHubUtils)
source(here("code", "load", "scenarios.R"))
source(here("code", "load", "load_local_results.R"))
source(here("code", "load", "plot_scenarios.R"))
source(here("code", "load", "plot_palettes.R"))

# Load data -----------------------------------------------------------------
# Get results
round_text <- paste0("round-", params$round)
results <- load_local_results(round = params$round) %>%
  filter(origin_date == scenarios[[round_text]][["origin_date"]])

# Filter results to countries with multiple models
multi_country <- distinct(results, model, location) %>%
  group_by(location) %>%
  tally() %>%
  filter(n >= 2) %>%
  pull(location)
results_multi_country <- filter(results, location %in% multi_country)

# Truth data ----------------------------------------------------------------
truth <- load_truth(
  truth_source = "JHU",
  temporal_resolution = "weekly",
  hub = "ECDC"
) |>
  select(-model)

# Formatting -----------------------------------------------------------------
# create consistent model and scenario colour palettes
palette <- plot_palettes(results,
                         scenario_reds = c("A", "C"),
                         scenario_blues = c("B", "D"))
target_dirs <- gsub("inc ", "", scenarios$targets)
names(target_dirs) <- gsub("Weekly ", "", names(target_dirs))
names(target_dirs) <- tools::toTitleCase(names(target_dirs))
