
library(vchartr)

vchart(electricity_mix) %>% 
  v_bar(aes(source, generation, select = country)) 


data("economics_long", package = "ggplot2")
vchart(economics_long) %>% 
  v_line(aes(date, value, select = variable)) %>%
  v_scale_x_date(
    date_breaks = 5,
    min = "1967-07-01",
    max = "2015-04-01"
  )
