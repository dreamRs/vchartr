
library(vchartr)

subset(electricity_mix, country %in% c("France", "Canada")) %>% 
  vchart() %>% 
  v_bar(aes(country, generation, fill = source)) %>% 
  v_scale_fill_discrete("Okabe-Ito")

subset(electricity_mix, country %in% c("France", "Canada")) %>% 
  vchart() %>% 
  v_bar(aes(country, generation, fill = source)) %>% 
  v_scale_fill_discrete("ggplot2")

# or 
subset(electricity_mix, country %in% c("France", "Canada")) %>% 
  vchart() %>% 
  v_bar(aes(country, generation, fill = source)) %>% 
  v_scale_fill_discrete(palette.colors(palette = "ggplot2")[-1])
