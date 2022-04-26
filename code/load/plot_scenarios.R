# Plot with location as each row in a facet grid
library(ggplot2)
library(forcats)
library(tidyr)
theme_set(theme_bw())

plot_scenarios <- function(results, scenario_caption,
                           target_variable,
                           columns = "model") {

  # Set model as a factor
  plot_data <- results %>%
    mutate(model = fct_infreq(model))

  # Set consistent model colours across all target variables
  model_colours <- palette.colors(palette = "Dark 2")
  names(model_colours) <- unique(plot_data$model)
  model_colours <- model_colours[!is.na(names(model_colours))]

  # Target variable
  variable_labels <- c("inc death" = "Weekly incident deaths",
                       "inc case" = "Weekly incident cases")

  plot_data <- results %>%
    filter(target_variable == !!target_variable) %>%
    mutate(variable_label = recode(target_variable, !!!variable_labels))

  variable_subtitle = unique(plot_data$variable_label)[1]

  # Specific quantiles
  plot_data <- plot_data %>%
    filter(quantile %in% c(0.05, 0.95)) %>%
    pivot_wider(values_from = value,
                names_prefix = "q", names_from = quantile)

  # Plot
  plot <- plot_data %>%
    ggplot(aes(x = target_end_date)) +
    labs(x = NULL, y = NULL,
         subtitle = paste0(variable_subtitle, "\n", scenario_caption)) +
    scale_x_date(date_labels = "%b") +
    scale_y_continuous(labels = scales::label_comma()) +
    theme(legend.position = "top")


  if (columns == "model") {
    scenario_colours <- c("#e66101", "#ca0020", "#0571b0", "#5e3c99")
    names(scenario_colours) <- unique(plot_data$scenario)

    plot <- plot +
      geom_ribbon(aes(fill = scenario,
                      ymin = q0.05, ymax = q0.95), alpha = 0.4) +
      scale_fill_manual(values = scenario_colours) +
      facet_grid(rows = vars(location), cols = vars(model),
                 scales = "free_y")
  } else {
    plot <- plot +
      geom_ribbon(aes(fill = model,
                      ymin = q0.05, ymax = q0.95), alpha = 0.4) +
      scale_fill_manual(values = model_colours) +
      facet_grid(rows = vars(location), cols = vars(scenario),
                 scales = "free_y")
  }

  return(plot)
}
