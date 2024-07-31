
library(vchartr)

# Basic Line Chart
vline(eco2mix, aes(date, solar))

# Basic Area Chart
varea(eco2mix, aes(date, solar))

# Smooth Line Chart
vline(tail(eco2mix, 10), aes(date, solar), dataserie_id = "line") %>%
  v_specs(
    line = list(
      style = list(curveType = "monotone")
    ),
    dataserie_id = "line"
  )

# Step Line Chart
vline(tail(eco2mix, 10), aes(date, solar), dataserie_id = "line") %>%
  v_specs(
    line = list(
      style = list(curveType = "stepAfter")
    ),
    dataserie_id = "line"
  )


# Add Line to existing chart
vline(eco2mix, aes(date, solar)) %>%
  v_add_line(aes(date, wind))

# Use long format for multiple lines
vline(eco2mix_long, aes(date, production, color = source))
varea(eco2mix_long, aes(date, production, fill = source))

# Add a range area
vline(temperatures, aes(date, `2024`)) %>%
  v_add_line(aes(date, average)) %>%
  v_add_range_area(aes(date, ymin = low, ymax = high)) %>%
  v_specs_legend(visible = TRUE)

# Change opacity & color for the area range
vline(temperatures, aes(date, `2024`)) %>%
  v_add_line(aes(date, average)) %>%
  v_add_range_area(
    aes(date, ymin = low, ymax = high),
    dataserie_id = "range_area"
  ) %>%
  v_specs_legend(visible = TRUE) %>%
  v_specs(
    area = list(
      style = list(
        fillOpacity = 1,
        fill = "#D8DEE9"
      )
    ),
    dataserie_id = "range_area"
  )

