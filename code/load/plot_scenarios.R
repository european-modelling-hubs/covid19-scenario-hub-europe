# Plot with location as each row in a facet grid
library(dplyr)
library(ggplot2)
library(forcats)
library(tidyr)
theme_set(theme_bw())
theme_replace(strip.background = element_blank())

##
##' Plot scenarios
##'
##' @param data modelled data as submitted
##' @param truth truth data (if given)
##' @param round scenario hub round
##' @param target_variable target variable to plot (cases, hospitalisations, or deaths)
##' @param columns the columns in the facet plot returned
##' @param model_colours colour palette to be used for models
##' @param scenario_colours colour palette to be used for scenarios
##' @param all_truth logical; whether to show all truth data (TRUE; default) or only up to the start of the scenarios (FALSE)
##' @param fixed_sample_alpha alpha of lines for individual samples
##' @param subsample proportion to subsample: 1 means plotting all samples
##' @param log whether to plot the y axis on the log scale; default: FALSE
##' @param per_100k plot values per 100k population
##' @param scenario_caption a caption for the scenario
##' @return a facet plot of scenarios
##' @author Katharine Sherratt
plot_scenarios <- function(data,
                           truth = NULL,
                           round = 1,
                           target_variable = "inc case",
                           columns = "model",
                           model_colours = NULL,
                           scenario_colours = NULL,
                           all_truth = TRUE,
                           fixed_sample_alpha = 0.1,
                           subsample = 1,
                           log = FALSE,
                           per_100k = TRUE) {

  # Relabel target variable
  variable_labels <- names(scenarios$targets)
  new_names <- unname(scenarios$targets)
  names(variable_labels) <- new_names

  plot_data <- data %>%
    filter(target_variable == !!target_variable) %>%
    mutate(variable_label = recode(target_variable, !!!variable_labels),
           model_sample = paste0(model, sample),
           scenario_sample = paste0(scenario_label, sample)) %>%
    left_join(enframe(model_colours,
                      name = "model", value = "model_colour"),
              by = "model") %>%
    left_join(enframe(scenario_colours,
                      name = "scenario_label", value = "scenario_colour"),
              by = "scenario_label") %>%
    group_by(model, location, horizon) %>%
    sample_frac(subsample)  %>%
    ungroup()

  # set plot subtitle
  variable_subtitle <- unique(plot_data$variable_label)[1]

  if (log) {
    y_scale <- ggplot2::scale_y_log10
  } else {
    y_scale <- ggplot2::scale_y_continuous
  }

  if (per_100k) {
    plot_data <- plot_data %>%
      select(-value) %>%
      rename("value" = "value_100k")
    truth <- truth %>%
      mutate(value = value / population * 100000)
    y_label <- paste0(variable_subtitle, " per 100,000")
  } else {
    y_label <- variable_subtitle
  }

  # get all-time max
  truth_peaks <- truth |>
    group_by(location, target_variable) |>
    filter(value == max(value)) %>%
    select(location, target_variable, value_alltime = value)

  plot_data <- plot_data |>
    left_join(truth_peaks, by = c("location", "target_variable"))

  # Plot
  plot_base <- plot_data %>%
    ggplot(aes(x = target_end_date, y = value)) +
    labs(x = NULL,
         y = y_label,
         caption = paste0(scenarios[[paste0("round-", round)]][["scenario_caption"]])) +
    geom_hline(aes(yintercept = value_alltime), lty = 3) +
    scale_x_date(date_labels = "%b", date_breaks = "2 months") +
    scale_y_continuous(labels = scales::label_comma()) +
    guides(colour = guide_legend(override.aes = list(alpha = 1,
                                                     size = 3))) +
    theme(legend.position = "top",
          legend.text=element_text(size=rel(1)))

  if (columns == "model") {
    # construct legend
    scenario_sample_colours <- deframe(distinct(plot_data,
                                                scenario_sample, scenario_colour))
    scenario_sample_breaks <- paste0(names(scenario_colours), "1")
    names(scenario_sample_breaks) <- names(scenario_colours)

    # plot
    plot <- plot_base +
      geom_line(aes(colour = scenario_sample),
                 alpha = fixed_sample_alpha) +
      scale_colour_manual(values = scenario_sample_colours,
                          breaks = scenario_sample_breaks,
                          labels = names(scenario_sample_breaks),
                          name = "Scenario") +
      facet_grid(rows = vars(location),
                 cols = vars(model),
                 scales = "free_y",
                 drop = TRUE)

  } else {
    # construct legend
    model_sample_colours <- deframe(distinct(plot_data,
                                     model_sample, model_colour))
    model_sample_breaks <- paste0(names(model_colours), "1")
    names(model_sample_breaks) <- names(model_colours)

    # plot
    plot <- plot_base +
      geom_line(aes(colour = model_sample),
                alpha = fixed_sample_alpha) +
      scale_colour_manual(values = model_sample_colours,
                          breaks = model_sample_breaks,
                          labels = names(model_sample_breaks),
                          name = "Model") +
      facet_grid(rows = vars(location),
                 cols = vars(scenario_label),
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
