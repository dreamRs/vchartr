
library(vchartr)
library(palmerpenguins)

# Create an histogram using a numeric variable
vchart(penguins) %>%
  v_hist(aes(flipper_length_mm))

# Customize some style properties
vchart(penguins) %>%
  v_hist(
    aes(flipper_length_mm),
    bar = list(
      style = list(
        stroke = "white",
        line_width = 1,
        fill = "forestgreen"
      )
    )
  )

# Use fill aesthetic to differentiate series
vchart(penguins) %>%
  v_hist(aes(flipper_length_mm, fill = species))

# Stack results
vchart(penguins) %>%
  v_hist(aes(flipper_length_mm, fill = species), stack = TRUE)

# Use custom colors
vchart(penguins) %>%
  v_hist(
    aes(flipper_length_mm, fill = species),
    bar = list(
      style = list(opacity = 0.5)
    )
  ) %>%
  v_specs_colors("#ffa232", "#b34df2", "#33a2a2")

