library(dplyr)
library(readr)
library(purrr)
library(tidyr)
library(covidHubUtils)

# Download model results ------------------------------------------------------
download_results <- function(models, dates,
                                          branch = "main",
                                          hub = "scenario") {

  # Get truth data ------------------------------------
  raw_truth <- covidHubUtils::load_truth(truth_source = "JHU",
                                         temporal_resolution = "weekly",
                                         hub = "ECDC")

  # Get models -----------------------------------------------------------
  models <- map2_dfr(.x = models, .y = forecast_dates,
                        ~ read_csv(paste0(
                          "https://raw.githubusercontent.com/",
                          "covid19-forecast-hub-europe/covid19-",
                                          hub,
                                          "-hub-europe/",
                                          branch,
                                          "/data-processed/",
                                          .x, "/",
                                          .y, "-", .x, ".csv")) %>%
                          mutate(model = .x))

  # Clean ---------------------------------------------------------
  results <- results %>%
    separate(target, into = c("horizon", "target_variable"), sep = " wk ahead ") %>%
    mutate(horizon = as.numeric(horizon)) %>%
    rename(prediction = value) %>%
    left_join(truth, by = c("location", "target_end_date", "target_variable"))

  return(forecasts)

}


