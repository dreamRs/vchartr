
library(vchartr)

# Draw a rectangle
vchart(cars) %>%
  v_scatter(aes(speed, dist)) %>%
  v_mark_rect(
    xmin = 10,
    xmax = 18,
    ymin = 20,
    ymax = 50
  )

# don't provide x or y to reach chart's limit
vchart(cars) %>%
  v_scatter(aes(speed, dist)) %>%
  v_mark_rect(
    xmin = 10,
    xmax = 18
  )
vchart(cars) %>%
  v_scatter(aes(speed, dist)) %>%
  v_mark_rect(
    ymin = 10,
    ymax = 18
  )


vchart(cars) %>%
  v_scatter(aes(speed, dist)) %>%
  v_mark_rect(
    xmin = "50%",
    xmax = "100%", # from right to left
    ymin = "50%",
    ymax = "100%" # note that for y it's from top to bottom
  )


# Whith date scale
vchart(temperatures) %>%
  v_line(aes(date, average)) %>%
  v_mark_rect(
    xmin = as.Date("2024-06-20"),
    xmax = as.Date("2024-09-22"),
    .label.text = "Summer"
  )


# Draw a polygon
vchart(cars) %>%
  v_scatter(aes(speed, dist)) %>%
  v_mark_polygon(
    coords = list(
      x = c(7, 22, 15),
      y = c(10, 50, 80)
    )
  )

