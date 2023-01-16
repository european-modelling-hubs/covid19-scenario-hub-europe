# Compare ensembles from samples v from quantiles
# Compare:
# a. Number of peaks
# b. Timing of peaks
# c. Duration of waves
# d. Cumulative burden

# peak <- ensembles |>
#   group_by(quantile, location, target_variable, scenario_id, model) |>
#   filter(value == max(value))

# Compare average differences at each quantile level -------------------------

diffs <- ensembles |>
  select(-n) |>
  group_by(quantile, location, target_variable, scenario_id) |>
  pivot_wider(names_from = model) |>
  summarise(diff_sum = sum(Samples - Quantiles),
            diff_med = median(Samples - Quantiles),
            .groups = "drop")

diffs_plot <- diffs |>
  mutate(quantile = forcats::fct_inseq(gsub("q0", "", quantile))) |>
  filter(!scenario_id == "Weighted") |>
  ggplot(aes(x = scenario_id, y = diff_med)) +
  geom_point(aes(col = quantile)) +
  scale_colour_viridis_d(option = "D") +
  geom_hline(aes(yintercept = 0), lty = 3, alpha = 0.5) +
  labs(y = "Median difference per 100k",
       x = "Scenario",
       fill = "Quantile",
       subtitle = "Differences between ensembles from samples or quantiles, median difference over time",
       caption = "Median difference: 52 week median of (sample ensemble - quantile ensemble) at each quantile") +
  facet_wrap(~location + target_variable,
             scales = "free_y") +
  theme_bw()
