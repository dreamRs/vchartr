
library(vchartr)
library(palmerpenguins)

vhist(penguins, aes(flipper_length_mm))

vhist(penguins, aes(flipper_length_mm)) %>%
  v_specs(
    bar = list(
      style = list(
        stroke = "white",
        lineWidth = 1
      )
    )
  )

vhist(penguins, aes(flipper_length_mm, fill = species))
vhist(penguins, aes(flipper_length_mm, fill = species), stack = TRUE)

vhist(penguins, aes(flipper_length_mm, fill = species)) %>%
  v_specs_colors("#ffa232", "#b34df2", "#33a2a2") %>%
  v_specs(
    bar = list(
      style = list(opacity = 0.5)
    )
  )
