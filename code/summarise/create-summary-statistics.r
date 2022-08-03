library(dplyr)
library(purrr)
library(tidyr)

# summary -----------------------------------------------------------------
summary_statistics <- function(x,
                               quantile_levels = c(0, 0.05, 0.25, 0.5, 0.75, 0.95, 1)) {
  ## maximum
  max_level <- x |>
    group_by(sample) |>
    filter(value == max(value)) |>
    ungroup() |>
    mutate(summary = "Max")

  ## minimum
  min_level <- x |>
    group_by(sample) |>
    filter(value == min(value)) |>
    ungroup() |>
    mutate(summary = "Min")

  ## combine
  all <- max_level |>
    rbind(min_level)

  ## first,  quantiles
  summary_quantiles <- all |>
    group_by(summary) |>
    summarise(
      value = round(quantile(value, quantile_levels)),
      name = paste0("q", sub("\\.", "_", quantile_levels)),
      .groups = "drop"
    )
  ## next, means
  summary_means <- all |>
    group_by(summary) |>
    summarise(
      value = round(mean(value)),
      name = "mean"
    )
  summaries <- summary_quantiles |>
    bind_rows(summary_means) |>
    pivot_wider()
}

create_summary_statistics <- function(data,
                                      summarise_location = FALSE) {
  ## create cumulative numbers for each incident quantity
  cumulative <- data |>
    filter(grepl("^inc", target_variable)) |>
    arrange(target_end_date) |>
    group_by_at(vars(-value, -horizon, -target_end_date)) |>
    mutate(value = cumsum(value)) |>
    ungroup() |>
    mutate(target_variable = sub("^inc ", "cum ", target_variable))

  data <- data |>
    rbind(cumulative)

  ## create summary statistics
  if (summarise_location) {
    data <- data |>
      group_by_at(vars(-location,
                       -sample, -value, -target_end_date, -horizon))
  } else {
    data <- data |>
      group_by_at(vars(-sample, -value, -target_end_date, -horizon))
  }

  summaries <- data |>
    nest() |>
    summarise(
      summary = map(data, summary_statistics),
      .groups = "drop") |>
    unnest(cols = "summary")

  ## rename cumulative summaries (max is just final, and min just initial)
  summaries <- summaries |>
    mutate(
      summary = if_else(summary == "Max" & grepl("^cum", target_variable),
        "Final", summary),
      summary = if_else(summary == "Min" & grepl("^cum", target_variable),
        "Initial", summary),
      )

  return(summaries)
}
