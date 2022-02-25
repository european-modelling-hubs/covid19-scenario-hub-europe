# Testing
library(dplyr)
library(readr)
library(here)

# Get 32 Euro hub locations
hub <- read_csv("https://raw.githubusercontent.com/covid19-forecast-hub-europe/covid19-scenario-hub-europe/main/data-locations/locations_eu.csv") %>%
  select("location_name", "location", "population")

# Source: Our World In Data
# Metadata: https://github.com/owid/covid-19-data/tree/master/public/data

# Get testing data
owid_test <- read_csv("https://github.com/owid/covid-19-data/blob/master/public/data/testing/covid-testing-all-observations.csv?raw=true") %>%
  mutate(location = countrycode::countrycode(`ISO code`, "iso3c", "iso2c")) %>%
  filter(location %in% hub$location) %>%
  select("location", "Date", "Entity",
         "Daily change in cumulative total":"Short-term tests per case")
