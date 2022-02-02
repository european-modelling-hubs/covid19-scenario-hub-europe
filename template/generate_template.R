library(tidyverse)
library(EuroForecastHub)

locations_names_eu <- get_hub_config("forecast_locations")
locations_eu <- read_csv("data-locations/locations_eu.csv")[, c("location_name", "location")]
target_variables_eu <- get_hub_config("target_variables")

template_us <- read_csv("https://raw.githubusercontent.com/midas-network/covid19-scenario-modeling-hub/fca8bc2d86553c5bd605341cfe073a048658a6be/data-processed/MyTeam-MyModel/2020-12-21-MyTeam-MyModel.csv")

template_eu <- template_us %>%
  mutate(location = as.factor(location),
         location_name = locations_names_eu[as.numeric(location)],
         # We only only integers
         value = round(value)) %>%
  # We remove this column because it's redundant with the scenario_id column
  select(-scenario_name) %>%
  select(-location) %>%
  left_join(locations_eu) %>%
  select(-location_name) %>%
  filter(endsWith(target, target_variables_eu)) %>%
  drop_na(location) %>%
  rename(origin_date = model_projection_date)

write_csv(template_eu, "template/2020-12-21-example-model.csv")

