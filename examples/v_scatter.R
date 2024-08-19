
library(vchartr)
data("penguins", package = "palmerpenguins")

# Basic scatter chart
vchart(penguins) %>%
  v_scatter(aes(x = flipper_length_mm, y = body_mass_g))

# Color series with discrete values
vchart(penguins) %>%
  v_scatter(aes(x = flipper_length_mm, y = body_mass_g, color = species))

# Color series with continuous values
vchart(penguins) %>%
  v_scatter(aes(x = bill_length_mm, y = bill_depth_mm, color = body_mass_g))

# Size of points
vchart(penguins) %>%
  v_scatter(aes(x = bill_length_mm, y = bill_depth_mm, size = body_mass_g))

# Size and color
vchart(penguins) %>%
  v_scatter(aes(
    x = bill_length_mm,
    y = bill_depth_mm,
    color = body_mass_g,
    size = body_mass_g
  ))

# With shapes
vchart(penguins) %>%
  v_scatter(
    aes(
      x = bill_length_mm,
      y = bill_depth_mm,
      color = species,
      shape = species
    )
  )



vchart(penguins) %>%
  v_scatter(
    aes(x = flipper_length_mm, y = body_mass_g, color = species)
  ) %>%
  v_scale_color_manual(c(
    Adelie = "#ffa232",
    Chinstrap = "#33a2a2",
    Gentoo = "#b34df2"
  ))
