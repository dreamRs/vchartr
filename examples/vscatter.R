
library(vchartr)
library(palmerpenguins)

vscatter(penguins, aes(x = flipper_length_mm, y = body_mass_g))

vscatter(
  penguins,
  aes(x = flipper_length_mm, y = body_mass_g, color = species)
)

vscatter(
  penguins,
  aes(
    x = bill_length_mm,
    y = bill_depth_mm,
    color = species,
    shape = species
  ),
  serie_id = "penguins_serie"
) %>%
  v_specs(
    shape = list(
      type = "ordinal",
      range = c("circle", "square", "triangle")
    ),
    serie = "penguins_serie"
  )

vscatter(
  penguins,
  aes(x = flipper_length_mm, y = body_mass_g, color = species)
) %>%
  v_colors_manual(
    Adelie = "#ffa232",
    Chinstrap = "#33a2a2",
    Gentoo = "#b34df2"
  )
