
library(vchartr)

data("mpg", package =  "ggplot2")

vchart(mpg, aes(displ, hwy)) %>%
  v_smooth()

vchart(mpg, aes(displ, hwy)) %>%
  v_smooth(se = FALSE)

vchart(mpg, aes(displ, hwy, color = class)) %>%
  v_smooth()

