# Explore features of projections:
# - number of peaks
# - size of peaks
# - timing of peaks
library(here)
library(dplyr)
library(lubridate)
library(ggpmisc)

# params <- list("round" = 1)
# source(here("code", "report", "prep.R"))
# data <- results_multi_country

# pre-process -------------------------------------------------------------
## add year-quarters to data
# data <- data |>
#   mutate(quarter = as.factor(quarter(target_end_date, type = "year.quarter")),
#          quarter_first = quarter(target_end_date, type = "date_first"),
#          quarter_last = quarter(target_end_date, type = "date_last"))
#
# quarter_labels <- data |>
#   distinct(quarter, quarter_first, quarter_last) %>%
#   mutate(months = paste0(month(quarter_first, label = TRUE),
#                          "-",
#                          month(quarter_last, label = TRUE),
#                          "'",
#                          substr(year(quarter_last), 3, 4))) |>
#   pull(months, quarter)
#
# data <- data |>
#   select(-c(quarter_first, quarter_last)) |>
#   mutate(quarter = recode(quarter, !!!quarter_labels))

# data <- data |>
#   #Aut/winter
#   filter(quarter %in% c("Oct-Dec'22", "Jan-Mar'23") &
#            target_variable %in% c("inc case", "inc hosp", "inc icu"))

# Detect peaks in each sample -----------------------------------------------
detect_peaks <- function(data) {
  data |>
    group_by(sample,
             model, scenario_label, location, target_variable) |>
    mutate(target_variable = as.factor(target_variable),
           peak = ggpmisc:::find_peaks(x = value, span = 5)) |>
    filter(peak)
}

# number of peaks ---------------------------------------------------------
plot_peaks_number <- function(peaks,
                              quantile_levels = c(0, 0.05, 0.25, 0.5, 0.75, 0.95, 1)) {

  # Summarise
  peaks_n <- peaks |>
    count(sample,
          model, scenario_label, location, target_variable,
          name = "peaks") |>
    ungroup() |>
    # take quantiles by model
    group_by(model, scenario_label, location, target_variable) |>
    summarise(value = round(quantile(peaks, quantile_levels)),
              name = paste0("q", sub("\\.", "_", quantile_levels))) |>
    pivot_wider()

  # Plot
  targets <- unique(peaks_n$target_variable)
  plot_n <- map(targets,
                ~ peaks_n |>
                    filter(target_variable == .x) |>
                    ggplot(aes(col = model, fill = model,
                               x = scenario_label)) +
                    geom_point(aes(y = q0_5),
                               position = position_dodge(0.5)) +
                    geom_linerange(aes(ymin = q0_05, ymax = q0_95),
                                   position = position_dodge(0.5)) +
                    scale_colour_manual(values = palette$models,
                                        aesthetics = c("colour", "fill")) +
                    scale_y_continuous(labels = scales::label_number(accuracy = 1)) +
                    labs(y = "Number of peaks", x = NULL,
                         col = NULL, fill = NULL) +
                    facet_grid(rows = "location", scales = "free", drop = TRUE) +
                    theme(legend.position = "top",
                          axis.text.x = element_text(angle = 10)))
  names(plot_n) <- targets
  return(plot_n)
}

# size of the maximum of each peak ---------------------------------
plot_peak_size <- function(peaks, truth,
                           quantile_levels = c(0, 0.05, 0.25, 0.5, 0.75, 0.95, 1)) {

  # Find previous max
  truth_peaks <- truth |>
    mutate(value_100k = value / population * 100000) |>
    group_by(location, target_variable) |>
    filter(value == max(value)) %>%
    select(location, target_variable, value_100k_alltime = value_100k)

  # Summarise projected max
  peaks_max <- peaks |>
    left_join(truth_peaks, by = c("location", "target_variable")) |>
    group_by(sample, model, scenario_label, location, target_variable) |>
    filter(value_100k == max(value_100k)) |>
    ungroup()

  # Plot: boxplot uncertainty around value per 100k at peak
  targets <- unique(peaks_max$target_variable)
  plot_max <- map(targets,
                  ~ peaks_max |>
                      filter(target_variable == .x) |>
                      group_by(model, scenario_label, location, target_variable) |>
                      ggplot(aes(x = target_end_date, col = model)) +
                      # Boxplot each samples' maximum value
                      # geom_boxplot(aes(y = value_100k), outlier.shape = 1) +
                      geom_violin(aes(y = value_100k, fill = NULL)) +
                      geom_jitter(aes(y = value_100k), alpha = 0.1) +
                      # Add dotted line to indicate highest observed peak
                      # geom_hline(aes(yintercept = value_100k_alltime), lty = 3) +
                      # Format
                      scale_colour_manual(values = palette$models, drop = TRUE) +
                      scale_x_date() +
                      labs(y = "Peak incidence per 100k", x = NULL,
                           col = NULL, fill = NULL,
                           subtitle = "Estimated size of largest peak") +
                      theme(legend.position = "top") +
                      facet_grid(rows = vars(location),
                                 cols = vars(scenario_label),
                                 scales = "free", drop = FALSE))
  names(plot_max) <- targets
  return(plot_max)
}
