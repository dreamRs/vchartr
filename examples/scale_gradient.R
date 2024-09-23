
library(vchartr)
data("penguins", package = "palmerpenguins")

vchart(penguins) %>%
  v_scatter(aes(
    x = bill_length_mm, 
    y = bill_depth_mm,
    color = body_mass_g
  )) %>% 
  v_scale_colour_gradient(
    name = "Body mass",
    low = "yellow",
    high = "red"
  )
