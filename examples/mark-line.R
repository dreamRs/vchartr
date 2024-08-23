
library(vchartr)

# Vertical line
vchart(meteo_paris) %>%
  v_line(aes(month, temperature_avg)) %>%
  v_mark_vline(x = "May")

# Vertical lines with labels
vchart(meteo_paris) %>%
  v_line(aes(month, temperature_avg)) %>%
  v_mark_vline(
    x = c("May", "September"),
    .label.text = c("May", "September")
  )

# Horizontal line
vchart(meteo_paris) %>%
  v_line(aes(month, temperature_avg)) %>%
  v_mark_hline(y = 12)

# Both horizontal and vertical lines
vchart(meteo_paris) %>%
  v_line(aes(month, temperature_avg)) %>%
  v_mark_vline(x = "May") %>%
  v_mark_hline(y = 12)

# lines on a scatter plot
vchart(cars) %>%
  v_scatter(aes(speed, dist)) %>%
  v_mark_vline(x = mean(cars$speed)) %>%
  v_mark_hline(y = mean(cars$dist))

# segment
vchart(cars) %>%
  v_scatter(aes(speed, dist)) %>%
  v_mark_segment(x = 8, xend = 22, y = 12, yend = 100)

# line on date scale
vchart(temperatures) %>%
  v_line(aes(date, average)) %>%
  v_mark_vline(x = as.Date("2024-06-20"))

# segment on date scale
vchart(temperatures) %>%
  v_line(aes(date, average)) %>%
  v_mark_segment(
    x = as.Date("2024-04-01"), xend = as.Date("2024-07-01"),
    y = 12, yend = 24,
    .line.style.lineDash = 0,
    .line.style.stroke = "firebrick"
  )

