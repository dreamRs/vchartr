
if (rlang::is_installed(c("sf", "geojsonio"))) {
  
  library(vchartr)
  library(sf)
  
  # Create map from sf object
  vmap(co2_world)
  
  # Draw data on the map
  vmap(co2_world, aes(name = name, fill = co2_per_capita))
  
  # Change projection and colors
  vmap(
    co2_world,
    aes(name = name, fill = co2_per_capita), 
    projection = "equalEarth"
  ) %>% 
    v_colors(
      range = c(
        "#FFFFE5", "#FFF7BC", "#FEE391", 
        "#FEC44F", "#FE9929", "#EC7014", 
        "#CC4C02", "#993404", "#662506"
      )
    ) %>% 
    v_legend(
      orient = "bottom"
    )
  
}
