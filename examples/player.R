
library(vchartr)

world_electricity %>% 
  subset(type == "detail") %>% 
  vchart() %>%
  v_bar(
    aes(source, generation, player = year)
  )


