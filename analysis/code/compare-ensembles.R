# Compare ensembles from samples v from quantiles
# Cumulative totals; peaks; average differences in value at each quantile
#

# # Compare cumulative -----------------------------------------------------
# cumulative_proj <- results |>
#   group_by(location, target_variable, scenario_id,
#            model, sample) |>
#   arrange(target_end_date) |>
#   mutate(proj_cumulative = cumsum(value)) |>
#   filter(target_end_date == max(target_end_date)) |>
#   ungroup() |>
#   mutate(proj_cumulative_p = proj_cumulative / population * 100)
#
# cumulative_past <- read_csv(here("analysis", "data", "obs.csv")) |>
#   filter(target_end_date >= min(results$target_end_date) - lubridate::weeks(52) &
#            target_end_date < min(results$target_end_date) &
#            location %in% unique(results$location) &
#            target_variable %in% unique(results$target_variable)) |>
#   group_by(location, target_variable) |>
#   arrange(target_end_date) |>
#   mutate(past_cumulative = cumsum(value)) |>
#   filter(target_end_date == max(target_end_date)) |>
#   ungroup() |>
#   mutate(past_cumulative_p = past_cumulative / population * 100) |>
#   select(location, target_variable, past_cumulative_p)
#
# cumulative <- left_join(cumulative_proj, cumulative_past)
# cumulative_exceeding <- cumulative |>
#   group_by(location, target_variable) |>
#   summarise(exceed = sum(proj_cumulative_p > past_cumulative_p),
#             n = n(),
#             exceed_p = exceed / n() * 100)


# # Compare peaks -----------------------------------------------------------
# span <- 3
# peaks <- results |>
#   mutate(sample_id = paste(location, target_variable, scenario_id, model, sample,
#                            sep = "-")) |>
#   group_by(sample_id) |>
#   mutate(target_variable = as.factor(target_variable),
#          peak_val = splus2R::peaks(x = value, span = span),
#          peak_obs = splus2R::peaks(x = obs, span = span),
#          peak_t_pos = peak_val & peak_obs,
#          peak_t_neg = !peak_val & !peak_obs,
#          peak_f_pos = peak_val & !peak_obs,
#          peak_f_neg = !peak_val & peak_obs) |>
#   filter(!is.na(obs)) # 28 weeks of data
#
# peak_obs <- peaks |>
#   summarise(n = n(),
#             true_pos = sum(peak_t_pos),
#             true_neg = sum(peak_t_neg),
#             false_pos = sum(peak_f_pos),
#             false_neg = sum(peak_f_neg),
#             sty = true_pos / (true_pos + false_neg),
#             spy = true_neg / (false_pos + true_neg))
#
# plot_obs <- peaks |>
#   ungroup() |>
#   select(target_end_date, location, target_variable, obs, peak_obs) |>
#   distinct() |>
#   mutate(target = paste(location, target_variable))
#
# plot_obs <- plot_obs |>
#   ggplot(aes(x = target_end_date, y = obs, col = target)) +
#   geom_line() +
#   geom_point(aes(alpha = peak_obs)) +
#   facet_wrap(~ target, scales = "free_y")

# # Compare average differences at each quantile level -------------------------

interval_ensembles <- ensembles |>
  mutate(quantile = as.numeric(as.character(sub("q0", "", quantile))),
         interval = round(2 * abs(0.5 - quantile), 2),
         type = if_else(quantile <= 0.5, "lower", "upper"))
duplicate_median <- interval_ensembles |>
  filter(quantile == 0.5) |>
  mutate(type = "upper")

width <- interval_ensembles |>
  bind_rows(duplicate_median) |>
  filter(scenario_id != "Weighted") |>
  select(-quantile) |>
  pivot_wider(names_from = "type") |>
  # Average across all scenarios and dates
  group_by(round, target, model, interval) |>
  summarise(upper = mean(upper),
            lower = mean(lower),
            .groups = "drop")

width_plot <- width |>
  ggplot(aes(x = interval,
             ymin = lower, ymax = upper,
             group = model,
             colour = model, fill = model)) +
  geom_ribbon(alpha = 0.25) +
  geom_linerange(alpha = 0.25) +
  geom_point(aes(y = lower), alpha = 0.5) +
  geom_point(aes(y = upper), alpha = 0.5) +
  scale_colour_brewer(palette = "Set1") +
  scale_fill_brewer(palette = "Set1") +
  labs(y = "Mean lower and upper interval bound per 100k",
       x = "Interval width",
       fill = "Ensemble data source",
       colour = "Ensemble data source") +
  facet_wrap(~target, nrow = 1,
             scales = "free_y") +
  theme_bw() +
  theme(legend.position = "bottom")


# caption <- "Mean central prediction intervals across time and scenarios. Mean lower and upper interval bounds: 52 week mean of quantiles in the sample and quantile ensembles"
