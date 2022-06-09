# Set scenario labels
library(tibble)
scenarios <- list(
  "targets" = c("Weekly incident deaths" = "inc death",
                "Weekly incident cases" = "inc case",
                "Weekly incident infections" = "inc infection",
                "Weekly hospital admissions" = "inc hosp",
                "Weekly critical care admissions" = "inc icu"),
  # ------------------------------------------------------------------------
  # Round 0
  "round-0" = list("round" = 0,
    "scenario_labels" = c(
                                       "A-2022-02-25" = "Strong/None",
                                       "B-2022-02-25" = "Strong/New",
                                       "C-2022-02-25" = "Weak/None",
                                       "D-2022-02-25" = "Weak/New"),
                   "origin_date" = as.Date("2022-03-13"),
                   "submission_window_end" = as.Date("2022-04-22"),
                   "scenario_caption" = "Strong/Weak = stronger/weaker immunity maintained over time; \n None/New = immune evading variant introduced May 2022"),
  # -------------------------------------------------------------------------
  # Round 1
  "round-1" = list("round" = 1,
    "scenario_labels" = c(
                                      "A-2022-05-22" = "Strong/Summer",
                                      "B-2022-05-22" = "Strong/Autumn",
                                      "C-2022-05-22" = "Weak/Summer",
                                      "D-2022-05-22" = "Weak/Autumn"),
    "origin_date" = as.Date("2022-05-22"),
    "submission_window_end" = as.Date("2022-06-03"),
    "scenario_caption" = "Strong/Weak = stronger/weaker immunity maintained over time; \n Summer/Autumn = 60+ second booster campaign starting in summer or autumn")
)
