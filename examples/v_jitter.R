
library(vchartr)

vchart(mpg) %>% 
  v_jitter(aes(cyl, hwy))

# Colour points
vchart(mpg) %>% 
  v_jitter(aes(cyl, hwy, colour = class))

# Use smaller width/height to emphasise categories
vchart(mpg) %>% 
  v_jitter(aes(cyl, hwy), width = 0.25)

# Use larger width/height to completely smooth away discreteness
vchart(mpg) %>% 
  v_jitter(aes(cty, hwy), width = 0.5, height = 0.5)
