
library(vchartr)

vchart(countries_gdp) %>%
  v_circlepacking(
    aes(lvl1 = REGION_UN, lvl2 = SUBREGION, lvl3 = ADMIN, value = GDP_MD)
  )


# With root level
vchart(countries_gdp) %>%
  v_circlepacking(
    aes(lvl1 = REGION_UN, lvl2 = SUBREGION, lvl3 = ADMIN, value = GDP_MD),
    use_root = "World"
  )


# Custom colors
vchart(countries_gdp) %>%
  v_circlepacking(
    aes(lvl1 = REGION_UN, lvl2 = SUBREGION, lvl3 = ADMIN, value = GDP_MD)
  ) %>%
  v_scale_color_manual(c(
    Oceania = "#E6AB02",
    Africa = "#1B9E77",
    Americas = "#D95F02",
    Asia = "#E7298A",
    Europe = "#66A61E",
    Antarctica = "#7570B3"
  ))

# Bubble Chart
vchart(countries_gdp) %>%
  v_circlepacking(
    aes(ADMIN, GDP_MD),
    label_visible = JS("d => d.value > 261921;"), # 261921 = 3rd Qu.
  )
