library(reldist)
library(cNORM)
library(purrr)

quantiles <- c(0.05, 0.25, 0.5, 0.75, 0.95)

results_weighted <- map_dfr(.x = quantiles,
                            ~ results |>
                              group_by(location, target_end_date) |>
                              summarise(quantile = .x,
                                        unweighted = quantile(x = value_100k, probs = .x),
                                        cnorm_harrel_davis = cNORM::weighted.quantile.harrell.davis(x = value_100k,
                                                                            probs = .x,
                                                                            weight = weight),
                                        cnorm_type_7 = cNORM::weighted.quantile.type7(x = value_100k,
                                                                            probs = .x,
                                                                            weight = weight),
                                        reldist_default = reldist::wtd.quantile(x = value_100k,
                                                                        q = .x,
                                                                        weight = weight)))

plot <- results_weighted |>
  pivot_longer(cols = starts_with(c("unweighted", "cnorm", "reldist")),
               names_to = "method") |>
  pivot_wider(names_from = quantile, names_prefix = "q") |>
  # add observations
  left_join(distinct(results,
                     location, target_variable,
                     target_end_date, obs_100k))

# Plot projection ----------------------------------
plot |>
  filter(!grepl("unweighted", method)) |>
  ggplot(aes(x = target_end_date)) +
  # 95%
  geom_line(aes(y = q0.95, col = method), lty = 2) +
  geom_line(aes(y = q0.05, col = method), lty = 2) +
  geom_ribbon(aes(ymin = q0.05, ymax = q0.95,
                 fill = method), alpha = 0.1) +
  # 50%
  geom_line(aes(y = q0.75, col = method), lty = 5) +
  geom_line(aes(y = q0.25, col = method), lty = 5) +
  geom_ribbon(aes(ymin = q0.25, ymax = q0.75,
                  fill = method), alpha = 0.1) +
  # median
  geom_line(aes(y = q0.5, col = method),
            alpha = 0.2, size = 1) +
  # observed
  geom_point(aes(y = obs_100k), size = 1) +
  # plot structure
  scale_colour_viridis_d(aesthetics = c("col", "fill"),
                         option = "C", end = 0.8) +
  facet_grid(rows = vars(location),
             scales = "free") +
  labs(x = NULL, y = "Incident deaths per 100,000",
       caption = "Showing median (line), 50% and 95% quantiles)") +
  theme_bw() +
  theme(legend.position = "bottom")

