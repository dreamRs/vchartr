
library(vchartr)

# Create a sunburst and auto hide labels
vchart(countries_gdp) %>%
  v_sunburst(
    aes(lvl1 = REGION_UN, lvl2 = SUBREGION, lvl3 = ADMIN, value = GDP_MD),
    gap = 10,
    labelAutoVisible = list(
      enable = TRUE
    ),
    labelLayout = list(
      align = "center",
      rotate = "radial"
    )
  )


# Custom tooltip
vchart(countries_gdp) %>%
  v_sunburst(
    aes(lvl1 = REGION_UN, lvl2 = SUBREGION, lvl3 = ADMIN, value = GDP_MD)
  ) %>% 
  v_specs_tooltip(
    mark = list(
      title = list(
        value = JS("val => val?.datum?.map(data => data.name).join(' / ')")
      )
    )
  )


# Custom layout options
vchart(countries_gdp) %>%
  v_sunburst(
    aes(lvl1 = REGION_UN, lvl2 = SUBREGION, lvl3 = ADMIN, value = GDP_MD),
    gap = 0,
    innerRadius = c(0, 0.4, 0.8),
    outerRadius = c(0.3, 0.7, 0.85),
    labelAutoVisible = list(
      enable = TRUE,
      circumference = 1
    ),
    labelLayout = list(
      list(
        align = "center",
        rotate = "tangential",
        offset = 0
      ),
      NULL,
      list(
        align = "start",
        rotate = "radial",
        offset = 15
      )
    )
  ) %>% 
  v_specs(padding = 70)
