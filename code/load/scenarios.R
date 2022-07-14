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
    "submission_window_end" = as.Date("2022-07-01"),
    "scenario_caption" = "_Guide to scenarios: Stronger or weaker immunity maintained over time ('Strong/Weak'); \n 60+ second booster campaign starting in summer or autumn ('Summer/Autumn')_",
    "table" = "<table>
  <tr>
    <td></td>
    <td>
      <b>Slow summer booster campaign</b><br>
      <ul>
          <li>2nd booster recommended for 60+</li>
          <li>Uptake reaches 50% of 1st booster coverage by 15th December</li>
          <li>Uptake starts <b>15th June*</b></li>
      </ul>
    </td>
    <td>
      <b>Fast autumn booster campaign</b><br>
      <ul>
          <li>2nd** booster recommended for 60+</li>
          <li>Uptake reaches 50% of 1st booster coverage by 15th December</li>
          <li>Uptake starts <b>15th September</b></li>
      </ul>
    </td>
  </tr>
  <tr>
    <td>
      <b>Optimistic slow immune waning</b><br>
      <ul>
        <li>60% reduction in immunity against infection</li>
        <li>In <b>8 months</b></li>
      </ul>
    </td>
    <td>
      Scenario A (<i>'Strong/Summer'</i>)
    </td>
    <td>
      Scenario B (<i>'Strong/Autumn'</i>)
    </td>
  </tr>
  <tr>
    <td>
      <b>Pessimistic fast immune waning</b><br>
      <ul>
        <li>60% reduction in immunity against infection</li>
        <li>In <b>3 months</b></li>
      </ul>
    </td>
    <td>
      Scenario C (<i>'Weak/Summer'</i>)
    </td>
    <td>
      Scenario D (<i>'Weak/Summer'</i>)
    </td>
  </tr>
</table>

_* If a second booster is already offered to 60+ (Greece, Netherlands), vaccination uptake continues as currently_

_** If a second booster is already offered to 60+ (Greece, Netherlands), a third booster dose is recommended_")
)
