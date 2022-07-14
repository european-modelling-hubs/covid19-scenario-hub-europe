# Create consistent colour palette across scenarios/models
library(dplyr)
library(forcats)

plot_palettes <- function(data,
                          scenario_reds = c("A", "B"),
                          scenario_blues = c("C", "D")) {
  # Set model as a factor with consistent model colours
  data <- data %>%
    mutate(model = fct_infreq(model))
  model_colours <- palette.colors(palette = "Dark 2")
  names(model_colours) <- unique(data$model)
  model_colours <- model_colours[!is.na(names(model_colours))]

  # set scenario colours
  names(scenario_reds) <- c("#e66101", # orange
                            "#ca0020") # red
  names(scenario_blues) <- c("#0571b0", # blue
                            "#5e3c99") # purple
  scenario_map <- enframe(c(scenario_reds, scenario_blues),
                          name = "colour",
                          value = "id")

  scenario_cols <- tibble("id" = substr(unique(data$scenario_id), 1, 1),
                          "label" = unique(data$scenario_label)) %>%
    left_join(scenario_map, by = "id")

  scenario_colours <- deframe(select(scenario_cols, label, colour))

  # set palettes
  plot_palettes <- list(models = model_colours,
                       scenarios = scenario_colours)
  return(plot_palettes)
}

