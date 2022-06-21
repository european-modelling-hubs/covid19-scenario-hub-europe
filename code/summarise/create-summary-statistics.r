library(dplyr)
library(purrr)
library(tidyr)

summary_statistics <- function(x, quantile_levels = c(0, 0.05, 0.25, 0.5, 0.75, 0.95, 1)) {
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

create_summary_statistics <- function(data) {
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

  ## create mean ensemble by just renaming the model to be all the same and
  ## re-assigning the sample model
  mean_ensemble <- data |>
    ## count models/samples and to facilitate creation of the
    ## central mean ensemble later
    group_by_at(vars(-model, -value, -sample)) |>
    mutate(
      n_models = n_distinct(model),
      n_samples = n()
    ) |>
    ungroup() |>
    mutate(
      model = "Mean ensemble",
      model_type = "ensemble"
    )

  ## create median-like ensemble by taking only the central samples
  central_mean_ensemble <- mean_ensemble |>
    group_by_at(vars(-model, -value, -sample)) |>
    arrange(value) |>
    mutate(sample = 1:n()) |>
    filter(
      sample > (n_samples - (n_samples / n_models)) / 2,
      sample < (n_samples + (n_samples / n_models)) / 2
    ) |>
    ungroup() |>
    mutate(
      model = "Central mean ensemble",
      model_type = "ensemble"
    )

  ensembles <- mean_ensemble |>
    rbind(central_mean_ensemble) |>
    select(-n_models, -n_samples)

  ## re-assigning the sample model
  ## append mean ensemble to data
  data <- data |>
    mutate(model_type = "individual") |>
    rbind(ensembles)

  ## create summary statistics
  summaries <- data |>
    group_by_at(vars(-sample, -value, -target_end_date, -horizon)) |>
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
