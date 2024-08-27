
library(vchartr)

data("penguins", package = "palmerpenguins")

vchart(penguins) %>% 
  v_boxplot(aes(species, flipper_length_mm))

vchart(penguins) %>% 
  v_boxplot(aes(species, flipper_length_mm, color = sex))


data("mpg", package = "ggplot2")

vchart(mpg) %>% 
  v_boxplot(aes(as.character(year), hwy))

vchart(mpg) %>% 
  v_boxplot(aes(class, hwy))

vchart(mpg) %>% 
  v_boxplot(aes(class, hwy, color = as.character(year)))
