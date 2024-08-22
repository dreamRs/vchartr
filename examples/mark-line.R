
library(vchartr)

# Vertical line
vchart(meteo_paris) %>%
  v_line(aes(month, temperature_avg)) %>% 
  v_mark_vline(x = "May")

# Vertical lines with labels
vchart(meteo_paris) %>%
  v_line(aes(month, temperature_avg)) %>% 
  v_mark_vline(
    x = c("May", "September"),
    .label.text = c("May", "September")
  )

# Horizontal line
vchart(meteo_paris) %>%
  v_line(aes(month, temperature_avg)) %>% 
  v_mark_hline(y = 12)

# Both horizontal and vertical lines
vchart(meteo_paris) %>%
  v_line(aes(month, temperature_avg)) %>% 
  v_mark_vline(x = "May") %>%
  v_mark_hline(y = 12)
