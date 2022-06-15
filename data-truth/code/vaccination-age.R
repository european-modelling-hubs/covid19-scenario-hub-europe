# European age-stratified vaccination data
library(dplyr)
library(readr)
library(tidyr)
library(lubridate)

# Set up ------------------------------------------------------------------
# date conversion for ecdc data
date_series <- tibble(date = seq.Date(from = as.Date("2020-01-01"), by = 7, to = Sys.Date()),
                      week = isoweek(date),
                      year = isoyear(date),
                      yearweek = paste0(year, "-W", ifelse(week < 10, "0", ""), week)) %>%
  select(yearweek, date)

# Get 32 Euro hub locations
hub <- read_csv("https://raw.githubusercontent.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/main/data-locations/locations_eu.csv") %>%
  select("location_name", "location", "population")

# Get vaccination data by age ------------------------------------------------
# Source: ECDC (https://www.ecdc.europa.eu/en/publications-data/data-covid-19-vaccination-eu-eea)
# - Note age data not available for Denmark (DE), Greece (GR), Netherlands (NL), United Kingdom (GB)
vax_age_raw <- read_csv("https://opendata.ecdc.europa.eu/covid19/vaccine_tracker/csv/data.csv")

# Clean
vax_age <- vax_age_raw %>%
  # keep only national level data
  filter(Region == ReportingCountry &
           ReportingCountry %in% unique(hub$location)) %>%
  # tidy names, dates
  select(
    yearweek = YearWeekISO,
    location = ReportingCountry,
    pop_group = TargetGroup,
    pop_group_denom = Denominator,
    pop_country_denom = Population,
    vaccine = Vaccine,
    dose_1 = FirstDose,
    dose_2 = SecondDose,
    dose_booster_1 = DoseAdditional1,
    dose_booster_2 = DoseAdditional2,
    dose_unknown = UnknownDose
  ) %>%
  left_join(date_series, by = "yearweek") %>%
  pivot_longer(cols = starts_with("dose"), names_to = "dose", values_to = "value")

# Weekly doses by target group --------------------------------------------
# all new weekly vaccine doses by group
vax_age_timeseries <- vax_age %>%
  group_by(date, location, pop_group, dose) %>%
  summarise(value = sum(value), .groups = "drop")

# First booster dose for 60 plus age group --------------------------------
# - note: each country has either "Age60+" or narrower age bands (but not both)
vax_60plus_boosters <- vax_age_timeseries %>%
  filter(dose == "dose_booster_1") %>%
  mutate(pop_group = ifelse(pop_group %in% c("1_Age60+",
                                           "Age60_69", "Age70_79", "Age80+"),
                      "sixty_plus",
                      ifelse(pop_group == "ALL", "all", NA))) %>%
  # keep totals and 60+ age group doses
  filter(!is.na(pop_group)) %>%
  group_by(location, pop_group) %>%
  summarise(value = sum(value, na.rm = TRUE), .groups = "keep") %>%
  pivot_wider(values_from = value,
              names_from = pop_group,
              names_prefix = "booster1_") %>%
  # add proportion of first boosters given to 60+ group
  mutate(booster1_sixty_plus_pp = booster1_sixty_plus / booster1_all)

# Save --------------------------------------------------------------------
write_csv(vax_age_timeseries,
          here::here("data-truth", "data", "vaccination-age-week.csv"))

write_csv(vax_60plus_boosters,
          here::here("data-truth", "data", "vaccination-60plus-booster1.csv"))

