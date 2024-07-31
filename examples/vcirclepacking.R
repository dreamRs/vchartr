
library(vchartr)

vcirclepacking(
  countries_gdp,
  aes(lvl1 = REGION_UN, lvl2 = SUBREGION, lvl3 = ADMIN, value = GDP_MD)
)

# With root level
vcirclepacking(
  countries_gdp,
  aes(lvl1 = REGION_UN, lvl2 = SUBREGION, lvl3 = ADMIN, value = GDP_MD),
  use_root = "World"
)

# Custom colors
vcirclepacking(
  countries_gdp,
  aes(lvl1 = REGION_UN, lvl2 = SUBREGION, lvl3 = ADMIN, value = GDP_MD)
) %>%
  v_specs_colors_manual(
    Oceania = "#E6AB02",
    Africa = "#1B9E77",
    Americas = "#D95F02",
    Asia = "#E7298A",
    Europe = "#66A61E",
    Antarctica = "#7570B3"
  )


# Bubble Chart
vcirclepacking(
  countries_gdp,
  aes(lvl = ADMIN, value = GDP_MD),
  label_visible = JS("d => d.value > 261921;"), # 261921 = 3rd Qu.
)
