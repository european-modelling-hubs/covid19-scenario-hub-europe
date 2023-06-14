# Plot ensemble results with samples
#
## Create ensemble with:
# source(here("analysis", "code", "create-ensembles.R"))
# ensembles <- create_ensembles(results = results,
#                               truncate_weeks = 2,
#                               quantiles = c(0.02, 0.1, 0.5, 0.90, 0.98))
library(dplyr)
library(ggplot2)

plot_ensemble_results <- function(ensembles, results,
                                  set_target,
                                  scenario_colours) {

  latest_data <- max(subset(results, !is.na(obs))$target_end_date)
  # Reshape data for plotting -----
  # ensembles
  ensembles <- ensembles |>
    mutate(model = ifelse(scenario_id == "Weighted",
                          "Weighted samples", model),
           value = ifelse(scenario_id == "Weighted" &
                            target_end_date < latest_data, NA, value)) |>
    pivot_wider(names_from = quantile) |>
    mutate(median = q0.5) |>
    select(-q0.5)

  # samples
  samples <- results |>
    mutate(model_sample = paste(location, target_variable, scenario_id,
                                model, sample,
                                sep = "-"),
           # relabel model to None
           model = "None") |>
    rename(q0.5 = value_100k) |>
    select(location, target_variable,
           target_end_date, scenario_id,
           model, model_sample, q0.5)

    # combine data and observations
  plot_data <- bind_rows(ensembles, samples) |>
    left_join(distinct(results,
                       location, target_variable,
                       target_end_date, obs_100k),
              by = c("location", "target_variable", "target_end_date"))

  # Format for plotting -----------------------------------------------------
  plot_data <- plot_data |>
    # set order for facet rows
    mutate(model = ordered(model,
                           levels = c("None",
                                      "Quantiles",
                                      "Samples",
                                      "Weighted samples"),
                           labels = c("A. All samples",
                                      "B. Quantile",
                                      "C. Simulations",
                                      "D. Weighted")),
           obs_100k = ifelse(model %in% c("Quantiles", "Samples"), NA, obs_100k))

  # Plot --------------------------------------------------------------
  plot <- plot_data |>
    mutate(target = paste(location, target_variable)) |>
    filter(target == set_target) |>
    ggplot(aes(x = target_end_date,
               fill = scenario_id, col = scenario_id)) +
    # ----- Geoms
    # ensembles
    geom_ribbon(aes(ymin = q0.01, ymax = q0.99),
                alpha = 0.1, col = NA) +
    geom_ribbon(aes(ymin = q0.25, ymax = q0.75),
                alpha = 0.4, col = NA) +
    geom_line(aes(y = median), size = 1) +
    # model samples
    geom_line(aes(y = q0.5, group = model_sample),
              alpha = 0.1) +
    # observed data as points
    geom_point(aes(y = obs_100k),
               colour = "black", size = 0.6, show.legend = FALSE) +
    # ----- Structure
    # facets
    facet_wrap(~ model,
               ncol = 1,
               scales = "fixed") +
    # labels
    labs(x = NULL, y = NULL,
         colour = "Scenario", fill = "Scenario",
         caption = set_target) +
    # colours and scales
    scale_colour_manual(values = scenario_colours,
                        aesthetics = c("colour", "fill")) +
    scale_x_date(date_breaks = "3 month", date_labels = "%b") +
    # theme
    theme_bw() +
    theme(legend.position = "bottom",
          axis.line = element_line(linewidth = 0.25),
          strip.background = element_blank(),
          #panel.spacing = unit(0, "lines"),
          panel.border = element_blank(),
          panel.grid = element_blank())
  if (set_target != "ES inc case") {
    plot <- plot +
      theme(strip.text = element_text(colour = "white"))
  }

  return(plot)
}
