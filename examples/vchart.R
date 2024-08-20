
library(vchartr)

# Use JS syntax to construct chart
vchart(
  type = "line",
  data = list(
    list(
      values = list(
        list(month = "January", value = 4.3),
        list(month = "February", value = 4.6),
        list(month = "March", value = 7.4),
        list(month = "April", value = 10.7),
        list(month = "May", value = 14.3),
        list(month = "June", value = 17.7),
        list(month = "July", value = 19.8),
        list(month = "August", value = 19.4),
        list(month = "September", value = 16.4),
        list(month = "October", value = 12.6),
        list(month = "November", value = 7.9),
        list(month = "December", value = 4.8)
      )
    )
  ),
  xField = "month",
  yField = "value",
  crosshair = list(
    xField = list(visible = TRUE)
  )
)

# or use R API
vchart(meteo_paris) %>%
  v_line(aes(month, temperature_avg)) %>%
  v_specs(
    crosshair = list(
      xField = list(visible = TRUE)
    )
  )

# or
vchart(meteo_paris, aes(month, temperature_avg)) %>%
  v_line() %>%
  v_specs(
    crosshair = list(
      xField = list(visible = TRUE)
    )
  )

# or
vchart() %>%
  v_line(aes(month, temperature_avg), data = meteo_paris) %>%
  v_specs(
    crosshair = list(
      xField = list(visible = TRUE)
    )
  )

