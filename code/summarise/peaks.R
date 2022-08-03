# Explore features of projections:
# - number of peaks
# - size of peaks
# - timing of peaks
library(here)
library(dplyr)
library(lubridate)
library(forcats)
library(ggpmisc)

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
plot_peak_number <- function(peaks,
                              quantile_levels = c(0.05, 0.5, 0.95)) {
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
                    group_by(model, scenario_label, location, target_variable) |>
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
                         caption = "Number of projected peaks",
                         col = NULL, fill = NULL) +
                    facet_grid(rows = "location", scales = "free", drop = TRUE) +
                    theme(legend.position = "top"))
  names(plot_n) <- targets
  return(plot_n)
}

# values and timing at the maximum of each peak -------------------------------
plot_peak_size <- function(peaks, truth) {

  # Find previous max
  truth_peaks <- truth |>
    mutate(value_100k = value / population * 100000) |>
    group_by(location, target_variable) |>
    filter(value == max(value)) %>%
    select(location, target_variable, value_100k_alltime = value_100k)
  peaks <- peaks |>
    left_join(truth_peaks, by = c("location", "target_variable"))

  # Plot: boxplot uncertainty around value per 100k at peak
  targets <- unique(peaks$target_variable)
  plot_size <- map(targets,
                  ~ peaks |>
                      filter(target_variable == .x) |>
                      group_by(model, scenario_label, location, target_variable) |>
                      ggplot(aes(x = target_end_date,
                                 col = model)) +
                     # geom_boxplot(aes(y = value_100k),
                     #               position = position_dodge(0.5)) +
                     geom_point(aes(y = value_100k), alpha = 0.7) +
                      # Add dotted line to indicate highest observed peak
                      geom_hline(aes(yintercept = value_100k_alltime), lty = 3) +
                      # Format
                      scale_colour_manual(values = palette$models, drop = TRUE) +
                      scale_x_date(date_breaks = "2 month", date_labels = "%b") +
                      labs(x = NULL,
                           y = paste0("Peak weekly incident ",
                                      gsub("^inc ", "", .x),
                                      " per 100k"),
                           col = NULL, fill = NULL,
                           caption = "Estimated size and timing of peaks over projection period
                           Dotted line indicates all-time highest observed peak") +
                      guides(colour = guide_legend(override.aes = list(alpha = 1))) +
                      theme(legend.position = "top") +
                      facet_grid(rows = vars(location),
                                 cols = vars(scenario_label),
                                 scales = "free", drop = FALSE))
  names(plot_size) <- targets
  return(plot_size)
}
