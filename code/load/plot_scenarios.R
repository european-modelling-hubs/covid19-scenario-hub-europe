# Plot with location as each row in a facet grid
library(dplyr)
library(ggplot2)
library(forcats)
library(tidyr)
# get plotting colours
source(here("code", "load", "plot_palettes.R"))
# get target variables
source(here("code", "load", "scenarios.R"))
theme_set(theme_bw())
theme_replace(strip.background = element_blank())
##
##' Plot scenarios
##'
##' @param data modelled data as submitted
##' @param truth truth data (if given)
##' @param all_truth logical; whether to show all truth data (TRUE; default) or only up to the start of the scenarios (FALSE)
##' @param scenario_caption a caption for the scenario
##' @param target_variable target variable to plot (cases, hospitalisations, or deaths)
##' @param columns the columns in the facet plot returned
##' @param model_colours colour palette to be used for models
##' @param scenario_colours colour palette to be used for scenarios
##' @return a facet plot of scenarios
##' @author Katharine Sherratt
plot_scenarios <- function(data,
                           truth = NULL,
                           round = 1,
                           target_variable = "inc case",
                           columns = "model",
                           model_colours = NULL,
                           scenario_colours = NULL,
                           all_truth = TRUE) {

  # Relabel target variable
  variable_labels <- names(scenarios$targets)
  new_names <- unname(scenarios$targets)
  names(variable_labels) <- new_names

  plot_data <- data %>%
    filter(target_variable == !!target_variable) %>%
    mutate(variable_label = recode(target_variable, !!!variable_labels))

# set plot subtitle
variable_subtitle = unique(plot_data$variable_label)[1]

  # Plot with all samples...
  # plot_data <- plot_data %>%
  #   select(-type) %>%
  #   pivot_wider(values_from = value,
  #               names_prefix = "q", names_from = quantile)
  #

  # Plot
  plot <- plot_data %>%
    ggplot(aes(x = target_end_date)) +
    labs(x = NULL, y = NULL,
         subtitle = paste0(variable_subtitle, "\n\n",
                           scenarios[[paste0("round-", round)]][["scenario_caption"]])) +
    scale_x_date(date_labels = "%b") +
    scale_y_continuous(labels = scales::label_comma()) +
    theme(legend.position = "top")

  if (columns == "model") {
    plot <- plot +
      geom_point(aes(y = value,
                     colour = scenario_id),
                alpha = 0.5) +
      # geom_line(aes(y = value,
      #                colour = scenario_id),
      #            alpha = 0.7) +
      scale_colour_manual(values = scenario_colours) +
      facet_grid(rows = vars(location),
                 cols = vars(model),
                 scales = "free_y",
                 drop = TRUE)

  } else {
    plot <- plot +
      geom_point(aes(y = value,
                     colour = model),
                 alpha = 0.5) +
      # geom_line(aes(y = value,
      #                colour = model),
      #            alpha = 0.7) +
      scale_colour_manual(values = model_colours) +
      facet_grid(rows = vars(location),
                 cols = vars(scenario_id),
                 scales = "free_y",
                 drop = TRUE)
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
