# Set scenario labels
library(tibble)
scenarios <- list(
  "round_0" = list("scenario_labels" = c(
                     "A-2022-02-25" = "Strong/None",
                     "B-2022-02-25" = "Strong/New",
                     "C-2022-02-25" = "Weak/None",
                     "D-2022-02-25" = "Weak/New"),
                   "origin_date" = as.Date("2022-03-13"),
                   "scenario_caption" = "Strong/Weak = stronger/weaker immunity maintained over time; \n None/New = immune evading variant introduced May 2022")
)
