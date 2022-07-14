library(dplyr)
library(lubridate)
library(ggplot2)
library(purrr)

plot_cumulative_summary <- function(data, truth,
                                    compare_last_year = TRUE) {

  # get cumulative [code from @sbfnk] ----------------------------------------
  ## take final cumulative values
  summary <- data |>
    group_by(location, scenario_label, target_variable, model,
             sample) |>
    arrange(target_end_date) |>
    mutate(cumulative = cumsum(value))
  final <- summary |>
    filter(target_end_date == max(target_end_date)) |>
    ungroup()

  ## take quantiles across samples
  quantile_levels = c(0, 0.05, 0.25, 0.5, 0.75, 0.95, 1)
  summary_quantiles <- final |>
    group_by(location, scenario_label, target_variable, model) |>
    summarise(
      value = round(quantile(cumulative, quantile_levels)),
      name = paste0("q", sub("\\.", "_", quantile_levels)),
      .groups = "drop"
    )

  ## calculate projected values as %
  summary_proj <- summary_quantiles |>
    left_join(distinct(truth,
                       location, population),
              by = "location") |>
    mutate(value_p = value / population,
           target_variable = gsub("^inc", "cum", target_variable))

  #  previous total --------------------------------------------
  summary_truth <- truth |>
    filter(target_end_date <= scenarios[[round_text]][["origin_date"]])

  if (compare_last_year) {
    summary_truth <- summary_truth |>
      filter(target_end_date >
               scenarios[[round_text]][["origin_date"]] - lubridate::weeks(52))
    plot_caption <- paste0("Dotted line at 52 weeks' cumulative total prior to start of projections")
  } else {
    plot_caption <- "Dotted line at all-time cumulative total before projections start"
  }
  summary_truth <- summary_truth |>
    group_by(location, target_variable) |>
    arrange(target_end_date) |>
    mutate(cumulative = cumsum(value),
           current_p = cumulative / population,
           target_variable = gsub("^inc", "cum", target_variable)) |>
    filter(target_end_date == max(target_end_date)) |>
    select(location, target_variable, current_p)

  # plot ---------------------------------------------------------------
  ## reframe data to wide
  cumulative_plot_data <- summary_proj |>
    ungroup() |>
    select(-value) |>
    group_by(location, scenario_label, target_variable, model) |>
    pivot_wider(names_from = name,
                values_from = value_p) |>
    left_join(summary_truth, by = c("location", "target_variable")) |>
    mutate(target_variable = gsub("^cum ", "", target_variable))

  ## set up plotting
  plot_cumulative <- function(data, target) {
    data |>
      filter(target_variable == target) |>
      ggplot(aes(x = scenario_label, col = model)) +
      geom_point(aes(y = q0_5), position = position_dodge(0.5)) +
      geom_linerange(aes(ymin = q0_05, ymax = q0_95),
                     position = position_dodge(0.5)) +
      geom_hline(aes(yintercept = current_p), lty = 3) +
      expand_limits(y = 0) +
      scale_y_continuous(labels = scales::label_percent()) +
      scale_colour_manual(values = palette$models) +
      labs(x = NULL, y = "% population", col = NULL,
           subtitle = paste0("Total incident ", target,
                             " over projection period"),
           caption = plot_caption) +
      facet_grid(rows = "location",
                 scales = "fixed",
                 drop = TRUE) +
      theme(legend.position = "top")
  }

  ## plot for all targets
  cumulative_plots <- map(unique(cumulative_plot_data$target_variable),
                          ~plot_cumulative(cumulative_plot_data,
                                           .x))
  names(cumulative_plots) <- unique(cumulative_plot_data$target_variable)

  return (cumulative_plots)
}
