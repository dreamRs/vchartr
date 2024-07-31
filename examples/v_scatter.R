
library(vchartr)
library(palmerpenguins)

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


vchart(penguins) %>% 
  v_scatter(
    aes(
      x = bill_length_mm,
      y = bill_depth_mm,
      color = species,
      shape = species
    ), 
    dataserie_id = "id"
  ) %>%
  v_specs(
    shape = list(
      type = "ordinal",
      range = c("circle", "square", "triangle")
    ),
    dataserie_id = "id"
  )



vscatter(
  penguins,
  aes(x = flipper_length_mm, y = body_mass_g, color = species)
) %>%
  v_specs_colors_manual(
    Adelie = "#ffa232",
    Chinstrap = "#33a2a2",
    Gentoo = "#b34df2"
  )
