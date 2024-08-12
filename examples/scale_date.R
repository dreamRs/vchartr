
library(vchartr)

vchart(eco2mix) %>%
  v_line(aes(date, solar)) %>%
  v_scale_x_date(name = "Date")

vchart(eco2mix) %>%
  v_bar(aes(date, solar)) %>%
  v_scale_x_date(name = "Date")


vchart(eco2mix) %>%
  v_line(aes(date, solar)) %>%
  v_scale_x_date(date_breaks = 10)


vchart(eco2mix) %>%
  v_line(aes(date, solar)) %>%
  v_scale_x_date(date_breaks = "2 years")


vchart(eco2mix) %>%
  v_line(aes(date, solar)) %>%
  v_scale_x_date(date_labels = "%m-%Y")


vchart(eco2mix) %>%
  v_line(aes(date, solar)) %>%
  v_scale_x_date(date_labels = "%b %Y")


vchart(eco2mix) %>%
  v_line(aes(date, solar)) %>%
  v_scale_x_date(
    date_labels = d3_format_time("%b %Y", locale = "fr-FR")
  )
