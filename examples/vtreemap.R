
library(vchartr)

# Basic Treemap Chart
vtreemap(
  countries_gdp,
  aes(lvl1 = REGION_UN, lvl2 = ADMIN, value = GDP_MD)
) %>% 
  v_specs(
    label = list(visible = TRUE)
  )

# Show all levels
vtreemap(
  countries_gdp,
  aes(lvl1 = REGION_UN, lvl2 = SUBREGION, lvl3 = ADMIN, value = GDP_MD)
) %>% 
  v_specs(
    label = list(visible = TRUE),
    nonLeaf = list(visible = TRUE),
    nonLeafLabel = list(visible = TRUE, position = "top")
  )
