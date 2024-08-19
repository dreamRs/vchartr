
library(vchartr)

# Basic Line Chart
vchart(eco2mix) %>% 
  v_line(aes(date, solar))

# Two lines
vchart(tail(eco2mix, 30), aes(date)) %>% 
  v_line(aes(y = solar)) %>% 
  v_line(aes(y = wind))

# Line chart with discrete x axis
vchart(data.frame(month = month.abb, value = sample(1:50, 12))) %>% 
  v_line(aes(month, value))

# Stroke color 
vchart(data.frame(month = month.abb, value = sample(1:50, 12))) %>% 
  v_line(
    aes(month, value),
    line = list(style = list(stroke = "firebrick"))
  )

# Smooth Line Chart
vchart(data.frame(month = month.abb, value = sample(1:50, 12))) %>% 
  v_line(
    aes(month, value), 
    line = list(style = list(curveType = "monotone"))
  )

# Step Line Chart
vchart(data.frame(month = month.abb, value = sample(1:50, 12))) %>% 
  v_line(
    aes(month, value),
    line = list(style = list(curveType = "stepAfter"))
  )

# Dash array 
vchart(data.frame(month = month.abb, value = sample(1:50, 12))) %>% 
  v_line(
    aes(month, value),
    line = list(style = list(lineDash = c(10, 10)))
  )

# Multiple lines
vchart(eco2mix_long) %>% 
  v_line(aes(date, production, color = source))

