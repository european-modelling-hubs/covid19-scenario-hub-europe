# Plot with location as each row in a facet grid
library(ggplot2)
library(forcats)
library(tidyr)
theme_set(theme_bw())

plot_scenarios <- function(data,
                           scenario_caption = NULL,
                           target_variable = "inc case",
                           columns = "model",
                           model_colours = NULL,
                           scenario_colours = NULL) {

  # Relabel target variable
  variable_labels <- c("inc death" = "Weekly incident deaths",
                       "inc case" = "Weekly incident cases")
  plot_data <- data %>%
    filter(target_variable == !!target_variable) %>%
    mutate(variable_label = recode(target_variable, !!!variable_labels))
  variable_subtitle = unique(plot_data$variable_label)[1]

  # Specific quantiles
  plot_data <- plot_data %>%
    mutate(quantile = ifelse(type == "point", 0.5, quantile)) %>%
    filter(quantile %in% c(0.05, 0.95) | type == "point") %>%
    select(-type) %>%
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
    plot <- plot +
      geom_line(aes(colour = scenario,
                    y = q0.5), alpha = 0.8) +
      scale_colour_manual(values = scenario_colours) +
      facet_grid(rows = vars(location), cols = vars(model),
                 scales = "free_y")

    if(all(c("q0.05", "q0.95") %in% names(plot_data))) {
      plot <- plot +
        geom_ribbon(aes(fill = scenario,
                        ymin = q0.05, ymax = q0.95), alpha = 0.4) +
        scale_fill_manual(values = scenario_colours)
    }
  } else {
    plot <- plot +
      geom_line(aes(colour = model,
                    y = q0.5), alpha = 0.8) +
      scale_colour_manual(values = model_colours) +
      facet_grid(rows = vars(location), cols = vars(scenario),
                 scales = "free_y")

    if(all(c("q0.05", "q0.95") %in% names(plot_data))) {
      plot <- plot +
        geom_ribbon(aes(fill = model,
                        ymin = q0.05, ymax = q0.95), alpha = 0.4) +
        scale_fill_manual(values = model_colours)
    }
  }

  return(plot)
}
