
library(vchartr)

# Basic Line Chart
vchart(eco2mix) %>% 
  v_line(aes(date, solar))

# Two lines
vchart(eco2mix, aes(date)) %>% 
  v_line(aes(y = solar)) %>% 
  v_line(aes(y = wind))

# Line chart with discrete x axis
vchart(data.frame(month = month.abb, value = sample(1:50, 12))) %>% 
  v_line(aes(month, value))

# Stroke color 
vchart(data.frame(month = month.abb, value = sample(1:50, 12))) %>% 
  v_line(aes(month, value), stroke = "firebrick")

# Smooth Line Chart
vchart(data.frame(month = month.abb, value = sample(1:50, 12))) %>% 
  v_line(aes(month, value), curve_type = "monotone")

# Step Line Chart
vchart(data.frame(month = month.abb, value = sample(1:50, 12))) %>% 
  v_line(aes(month, value), curve_type = "stepAfter")

# Dash array 
vchart(data.frame(month = month.abb, value = sample(1:50, 12))) %>% 
  v_line(aes(month, value), line_dash = c(10, 10))

# Multiple lines
vchart(eco2mix_long) %>% 
  v_line(aes(date, production, color = source))

