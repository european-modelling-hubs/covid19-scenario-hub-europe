library(dplyr)
library(purrr)
library(tidyr)

# Ensemble ----------------------------------------------------------------
#' @param data
#' @param append_to_data add ensemble model as rows to existing data

create_ensembles <- function(data,
                            append_to_data = TRUE) {
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

  if (append_to_data) {
    ## re-assigning the sample model
    ## append mean ensemble to data
    ensembles <- data |>
      mutate(model_type = "individual") |>
      rbind(ensembles)
  }

  return(ensembles)
}
