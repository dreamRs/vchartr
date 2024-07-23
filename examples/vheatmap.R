
library(vchartr)

# Heatmap with continuous fill variable
vheatmap(
  co2_emissions,
  aes(x = year, y = country, fill = co2_per_capita)
)

vheatmap(
  co2_emissions,
  aes(x = year, y = country, fill = co2_per_capita)
) %>%
  v_colors(
    range = rev(
      c("#8C510A", "#BF812D", "#DFC27D", "#F6E8C3",
        "#C7EAE5", "#80CDC1", "#35978F", "#01665E")
    )
  )



# Heatmap with discrete fill variable
vheatmap(
  co2_emissions,
  aes(x = year, y = country, fill = co2_growth_change)
)

vheatmap(
  co2_emissions,
  aes(x = year, y = country, fill = co2_growth_change)
) %>%
  v_colors_manual(
    Increase = "firebrick",
    Decrease = "forestgreen"
  )

