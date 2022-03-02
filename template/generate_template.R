library(tidyverse)
library(EuroForecastHub)

set.seed(20220302)

locations_names_eu <- get_hub_config("forecast_locations")
locations_eu <- read_csv("data-locations/locations_eu.csv")[, c("location_name", "location")]
target_variables_eu <- get_hub_config("target_variables")
quantiles <- get_hub_config("forecast_type")[["quantiles"]]

today <- lubridate::today()

scenarios <- c(glue::glue("A-{today}"), glue::glue("B-{today}"))

truth_eu <- covidHubUtils::load_truth(
  truth_source = "JHU",
  temporal_resolution = "weekly",
  truth_end_date = today,
  hub = "ECDC"
)

template_eu <- truth_eu %>%
  select(location, target_end_date, target_variable, value) %>%
  filter(target_end_date == max(target_end_date)) %>%
  left_join(data.frame(scenario_id = scenarios), by = character()) %>%
  mutate(
    origin_date = target_end_date,
    target_end_date = target_end_date + lubridate::weeks(1),
    horizon = "1 wk",
    value = round(value * runif(2, min = 0.8, max = 1.2)),
    type = "quantile",
    .keep = "unused"
  )

template_eu <- rbind(
  template_eu,
  template_eu %>%
    mutate(
      horizon = gsub("^1", "2", horizon),
      value = round(value * runif(2, min = 0.8, max = 1.2)),
      target_end_date = target_end_date + lubridate::weeks(1),
    )
)

template_eu <- template_eu %>%
  group_by(across()) %>%
  summarise(
    quantile = quantiles,
    value = round(qnorm(quantiles, mean = value, sd = value / 5))
  )

write_csv(template_eu, glue::glue("template/{today}-example-model.csv"))

