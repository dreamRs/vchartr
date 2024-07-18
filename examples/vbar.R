
library(vchartr)
data("mpg", package = "ggplot2")

# Classic Bar Chart
vbar(table(Class = mpg$class), aes(Class, Freq))

# Horizontal Bar Chart
vbar(table(Class = mpg$class), aes(Class, Freq), direction = "horizontal")

# Grouped Bar Chart
vbar(
  table(Class = mpg$class, Year = mpg$year),
  aes(Class, Freq, fill = Year)
)

# Horizontal Grouped Bar Chart
vbar(
  table(Class = mpg$class, Year = mpg$year),
  aes(Class, Freq, fill = Year),
  direction = "horizontal"
)

# Stacked Bar Chart
vbar(
  table(Class = mpg$class, Year = mpg$year),
  aes(Class, Freq, fill = Year),
  stack = TRUE
)

# Percentage Stacked Bar Chart
vbar(
  table(Class = mpg$class, Year = mpg$year),
  aes(Class, Freq, fill = Year),
  stack = TRUE,
  percent = TRUE
)

