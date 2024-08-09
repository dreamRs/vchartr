
library(vchartr)

# Basic Treemap Chart
vchart(countries_gdp) %>%
  v_treemap(aes(lvl1 = REGION_UN, lvl2 = ADMIN, value = GDP_MD))

# With labels
vchart(countries_gdp) %>%
  v_treemap(
    aes(lvl1 = REGION_UN, lvl2 = ADMIN, value = GDP_MD),
    label = list(visible = TRUE)
  )

# Show all levels
vchart(countries_gdp) %>%
  v_treemap(
    aes(lvl1 = REGION_UN, lvl2 = ADMIN, value = GDP_MD),
    label = list(visible = TRUE),
    nonLeaf = list(visible = TRUE),
    nonLeafLabel = list(visible = TRUE, position = "top")
  )
