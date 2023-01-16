# Plot ensemble results with samples
library(dplyr)
library(ggplot2)

plot_ensemble_results <- function(ensembles, results,
                                  set_target_variable = "inc case",
                                  set_location = "NL") {

  # Reshape data for plotting -----
  # ensembles
  ensembles <- ensembles |>
    pivot_wider(names_from = quantile) |>
    mutate(median = q0.5) |>
    select(-q0.5)

  # samples
  samples <- results |>
    mutate(model_sample = paste0(scenario_id, "_", model, "_", sample),
           model = "Raw samples") |>
    rename(q0.5 = value_100k) |>
    select(location, target_variable, target_end_date, scenario_id,
           model, model_sample, q0.5)

  samples_wtd <- samples |>
    mutate(scenario_id = "Weighted")

  # combine data and observations
  plot_data <- bind_rows(ensembles, samples, samples_wtd) |>
    left_join(distinct(results,
                       location, target_variable,
                       target_end_date, obs_100k),
              by = c("location", "target_variable", "target_end_date"))

  # Format for plotting
  plot_data <- plot_data |>
    # set order for facet rows
    mutate(model = ordered(model,
                           levels = c("Raw samples",
                                      "All samples",
                                      "Model quantiles"))) |>
    # get proper location names
    left_join(results |>
                distinct(location, location_name),
              by = "location") |>
    # keep only one target
    filter(location == set_location &
             target_variable == set_target_variable)

  # Plot -----
  plot <- plot_data |>
    ggplot(aes(x = target_end_date)) +
    # ----- Geoms
    # ensembles
    geom_ribbon(aes(ymin = q0.01, ymax = q0.99,
                    fill = model), alpha = 0.2) +
    geom_ribbon(aes(ymin = q0.05, ymax = q0.95,
                    fill = model), alpha = 0.4) +
    geom_ribbon(aes(ymin = q0.25, ymax = q0.75,
                    fill = model), alpha = 0.6) +
    geom_line(aes(y = median,
                  col = model), size = 1) +
    # model samples
    geom_line(aes(y = q0.5,
                  group = model_sample, col = model), alpha = 0.1) +
    # observed data as points
    geom_point(aes(y = obs_100k), size = 0.7) +
    # ----- Structure
    # facets
    facet_grid(rows = vars(model),
               cols = vars(scenario_id),
               scales = "free") +
    # labels
    labs(x = NULL,
         y = paste0("Incidence per 100,000"),
         subtitle = paste0(unique(plot_data$location_name),
                           " ", gsub("inc ", "", set_target_variable), " ",
                           "multi-model projections, 2022-23"),
         caption = "Showing median, 50%, 95%, and 99% confidence") +
    # colours
    scale_colour_brewer(type = "qual", palette = "Dark2",
                        aesthetics = c("colour", "fill")) +
    scale_x_date(date_breaks = "3 month", date_labels = "%b") +
    # theme
    theme_bw() +
    theme(legend.position = "bottom")

  return(plot)
}
