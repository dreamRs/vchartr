
library(vchartr)

# Default radar chart
subset(electricity_mix, country == "Germany") %>%
  vchart() %>%
  v_radar(aes(source, generation))

# Without area
subset(electricity_mix, country == "Germany") %>%
  vchart() %>%
  v_radar(
    aes(source, generation),
    area = list(visible = FALSE)
  )


# Mutliple series
subset(electricity_mix, country %in% c("Germany", "Canada")) %>%
  vchart() %>%
  v_radar(aes(source, generation, color = country))



# Custom axes
subset(electricity_mix, country == "Germany") %>%
  vchart() %>%
  v_radar(aes(source, generation)) %>%
  v_scale_y_continuous(min = 0, max = 200)

subset(electricity_mix, country == "Germany") %>%
  vchart() %>%
  v_radar(aes(source, generation)) %>%
  v_scale_y_continuous(
    grid = list(smooth = FALSE),
    domainLine = list(visible = FALSE)
  ) %>%
  v_scale_x_discrete(
    label = list(space = 20),
    domainLine = list(visible = FALSE)
  )
