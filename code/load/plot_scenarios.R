# Plot with location as each row in a facet grid
library(dplyr)
library(ggplot2)
library(forcats)
library(tidyr)
theme_set(theme_bw())
##
##' Plot scenarios
##'
##' @param data modelled data as submitted
##' @param truth truth data (if given)
##' @param all_truth logical; whether to show all truth data (TRUE; default) or only up to the start of the scenarios (FALSE)
##' @param scenario_caption a cpation for the scenario
##' @param target_variable target variable to plot (cases, hospitalisations, or deaths)
##' @param columns the columns in the facet plot returned
##' @param model_colours colour palette to be used for models
##' @param scenario_colours colour palette to be used for scenarios
##' @return a facet plot of scenarios
##' @author Katharine Sherratt
plot_scenarios <- function(data,
                           truth = NULL,
                           scenario_caption = NULL,
                           target_variable = "inc case",
                           columns = "model",
                           model_colours = NULL,
                           scenario_colours = NULL,
                           all_truth = TRUE) {

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
      facet_grid(drop = TRUE,
                 rows = vars(location), cols = vars(scenario),
                 scales = "free_y")

    if(all(c("q0.05", "q0.95") %in% names(plot_data))) {
      plot <- plot +
        geom_ribbon(aes(fill = model,
                        ymin = q0.05, ymax = q0.95), alpha = 0.4) +
        scale_fill_manual(values = model_colours)
    }
  }

  if (!is.null(truth)) {
    ## show 12 weeks of data
    truth <- truth %>%
      filter(target_variable == !!target_variable,
             target_end_date > min(plot_data$target_end_date) - 7 * 12,
             location %in% unique(plot_data$location))
    if (!all_truth) {
      truth <- truth %>%
        filter(target_end_date < min(plot_data$target_end_date))
    }

    plot <- plot +
      geom_point(data = truth, aes(y = value), alpha = 0.5, shape = 16)
  }

  return(plot)
}
