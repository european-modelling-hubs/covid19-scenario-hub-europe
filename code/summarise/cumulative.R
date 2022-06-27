
data <- results_multi_country

# take final cumulative values
summary <- data |>
  group_by(location, scenario_id, target_variable, model,
           sample) |>
  arrange(target_end_date) |>
  mutate(cumulative = cumsum(value))
final <- summary |>
  filter(target_end_date == max(target_end_date)) |>
  ungroup()

# take quantiles across samples
quantile_levels = c(0, 0.05, 0.25, 0.5, 0.75, 0.95, 1)
summary_quantiles <- final |>
  group_by(location, scenario_id, target_variable, model) |>
  summarise(
    value = round(quantile(cumulative, quantile_levels)),
    name = paste0("q", sub("\\.", "_", quantile_levels)),
    .groups = "drop"
  )

# calculate as %
summary_p <- summary_quantiles |>
  left_join(distinct(truth,
                     location, population),
            by = "location") |>
  mutate(value_p = value / population,
         target_variable = gsub("^inc", "cum", target_variable))

# add cumulative to date
summary_truth <- truth |>
  filter(target_end_date <= scenarios[[round_text]][["origin_date"]]) |>
  group_by(location, target_variable) |>
  arrange(target_end_date) |>
  mutate(cumulative = cumsum(value),
         current_p = cumulative / population,
         target_variable = gsub("^inc", "cum", target_variable)) |>
  filter(target_end_date == max(target_end_date)) |>
  select(location, target_variable, current_p)

# plot
cumulative_plot <- summary_p |>
  ungroup() |>
  select(-value) |>
  group_by(location, scenario_id, target_variable, model) |>
  pivot_wider(names_from = name,
              values_from = value_p) |>
  left_join(summary_truth, by = c("location", "target_variable")) |>
  mutate(target_variable = gsub("^cum ", "", target_variable))

cumulative_plot <- split(cumulative_plot,
                         cumulative_plot$target_variable)

library(ggplot2)
target_var <- names(cumulative_plot)
target_var <- "infection"

cumulative_plot[[target_var]] |>
  ggplot(aes(x = scenario_id,
             col = model)) +
  geom_point(aes(y = q0_5), position = position_dodge(0.5)) +
  geom_linerange(aes(ymin = q0_05, ymax = q0_95),
                 position = position_dodge(0.5)) +
  geom_hline(aes(yintercept = current_p), lty = 3) +
  scale_y_continuous(labels = scales::label_percent()) +
  scale_colour_manual(values = palette$models) +
  labs(x = NULL, y = "% population",
       col = NULL,
       caption = paste0(gsub("^cum", "Total projected", target_var),
                        "s ",
                        scenarios[[round_text]][["origin_date"]],
                        " to ",
                        max(data$"target_end_date"),
                        "\n",
                        "Dotted line indicates cumulative total at the start of projection period")) +
  facet_grid(rows = "location",
             scales = "free", drop = TRUE) +
  theme(legend.position = "top")


