
library(vchartr)

subset(electricity_mix, country %in% c("France", "Canada")) %>% 
  vchart() %>% 
  v_bar(aes(country, generation, fill = source)) %>% 
  v_scale_fill_manual(c(
    "oil" = "#80549f",
    "coal" = "#a68832",
    "solar" = "#d66b0d",
    "gas" = "#f20809",
    "wind" = "#72cbb7",
    "hydro" = "#2672b0",
    "nuclear" = "#e4a701"
  ))

vchart(palmerpenguins::penguins) %>%
  v_scatter(
    aes(x = flipper_length_mm, y = body_mass_g, color = species)
  ) %>%
  v_scale_color_manual(c(
    Adelie = "#ffa232",
    Chinstrap = "#33a2a2",
    Gentoo = "#b34df2"
  ))
