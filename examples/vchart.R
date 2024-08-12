
library(vchartr)

# Use JS syntax to construct chart
vchart(
  type = "bar",
  data = list(
    list(
      id = "bardata",
      values = list(
        list(day = "Monday", value = 12),
        list(day = "Tuesday", value = 8),
        list(day = "Wednesday", value = 18),
        list(day = "Thursday", value = 25),
        list(day = "Friday", value = 14),
        list(day = "Saturday", value = 5),
        list(day = "Sunday", value = 7)
      )
    )
  ),
  xField = "day",
  yField = "value",
  crosshair = list(
    xField = list(visible = TRUE)
  )
)

# or use R API
data.frame(
  day = c(
    "Monday", "Tuesday", "Wednesday",
    "Thursday", "Friday", "Saturday", "Sunday"
  ),
  value = c(12, 8, 18, 25, 14, 5, 7)
) %>%
  vchart() %>%
  v_bar(aes(day, value)) %>%
  v_specs(
    crosshair = list(
      xField = list(visible = TRUE)
    )
  )

