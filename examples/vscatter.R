
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
  dataserie_id = "penguins"
) %>%
  v_specs(
    shape = list(
      type = "ordinal",
      range = c("circle", "square", "triangle")
    ),
    dataserie_id = "penguins"
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
