library(vchartr)
data("penguins", package = "palmerpenguins")

vchart(penguins) %>%
  v_scatter(aes(
    x = bill_length_mm, 
    y = bill_depth_mm,
    size = body_mass_g
  )) %>% 
  v_scale_size(
    name = "Body mass",
    range = c(1, 20)
  )
