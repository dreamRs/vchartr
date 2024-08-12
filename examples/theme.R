
library(vchartr)

chart <- subset(
  electricity_mix,
  country %in% c("Germany", "Brazil", "South Korea")
) %>%
  vchart() %>%
  v_bar(aes(country, generation, fill = source))

# Default appearance
chart

# Change background color
chart %>%
  v_theme(.backgroundColor = "#2F2E2F")

# Change default color palette
chart %>%
  v_theme(
    .colorPalette = palette.colors(n = 8, palette = "Okabe-Ito")[-1]
  )

# Axis grid color
chart %>%
  v_theme(.axisGridColor = "red")
# same as
chart %>%
  v_theme(
    component = list(
      axis = list(
        grid = list(
          style = list(
            # lineWidth = 3, # but more options available
            stroke = "red"
          )
        )
      )
    )
  )
# see https://www.unpkg.com/@visactor/vchart-theme@1.11.6/public/light.json
# for all possibilities
