# Unweighted simple ensemble from all models/samples

quantile_levels = c(0, 0.05, 0.25, 0.5, 0.75, 0.95, 1)

ensemble <- results |>
  group_by(location, target_end_date, scenario_id) |>
  summarise(
    value = round(quantile(value_100k, quantile_levels)),
    name = paste0("q", sub("\\.", "", quantile_levels)),
    .groups = "drop"
  ) |>
  tidyr::pivot_wider()

# PLOT simple ensemble projection
ensemble |>
  ggplot(aes(x = target_end_date)) +
  geom_ribbon(aes(ymin = q005, ymax = q095), alpha = 0.2) +
  geom_line(aes(y = q05)) +
  facet_grid(cols = vars(scenario_id),
             rows = vars(location),
             scales = "free") +
  labs(x = NULL,
       y = "deaths/100k",
       subtitle = "Simple ensemble") +
  theme_bw() +
  theme(legend.position = "none")
