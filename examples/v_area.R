
library(vchartr)

# Basic Area Chart
vchart(eco2mix) %>% 
  v_area(aes(date, solar))

# Two areas
vchart(eco2mix, aes(date)) %>% 
  v_area(aes(y = solar)) %>% 
  v_area(aes(y = wind))

# Line chart with discrete x axis
vchart(data.frame(month = month.abb, value = sample(1:50, 12))) %>% 
  v_area(aes(month, value))

# Fill color 
vchart(data.frame(month = month.abb, value = sample(1:50, 12))) %>% 
  v_area(aes(month, value), area_style = list(fill = "firebrick", fill_opacity = 0.9))

# Smooth Area Chart
vchart(data.frame(month = month.abb, value = sample(1:50, 12))) %>% 
  v_area(aes(month, value), area_style = list(curve_type = "monotone"))

# Step Area Chart
vchart(data.frame(month = month.abb, value = sample(1:50, 12))) %>% 
  v_area(aes(month, value), area_style = list(curve_type = "stepAfter"))

# Multiple areas
vchart(eco2mix_long) %>% 
  v_area(aes(date, production, fill = source))

vchart(eco2mix_long) %>% 
  v_area(aes(date, production, fill = source), stack = TRUE, fill_opacity = 1)


# Range area chart
vchart(temperatures, aes(date)) %>% 
  v_area(aes(ymin = low, ymax = high)) %>% 
  v_line(aes(y = average))

within(temperatures, {difference = `2024` - average}) %>% 
  vchart(aes(date)) %>% 
  v_area(
    aes(ymin = average, ymax = `2024`, difference = difference),
    area_style = list(
      fill = JS(
        "data => { return data.difference > 0 ? '#F68180' : '#2F64FF' ; }"
      ),
      fill_opacity = 1
    )
  ) 
