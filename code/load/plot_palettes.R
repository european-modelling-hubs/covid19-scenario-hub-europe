# Create consistent colour palette across scenarios/models
library(dplyr)
library(forcats)

plot_palettes <- function(data) {
  # Set model as a factor with consistent model colours
  data <- data %>%
    mutate(model = fct_infreq(model))
  model_colours <- palette.colors(palette = "Dark 2")
  names(model_colours) <- unique(data$model)
  model_colours <- model_colours[!is.na(names(model_colours))]

  # set scenario colours
  scenario_colours <- c("#e66101", "#ca0020", "#0571b0", "#5e3c99")
  names(scenario_colours) <- unique(data$scenario)

  plot_palettes <- list(models = model_colours,
                       scenarios = scenario_colours)
  return(plot_palettes)
}

