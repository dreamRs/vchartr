
library(vchartr)

vline(eco2mix, aes(as.numeric(date), solar)) %>%
  v_scale_x_date(name = "Date")


vline(eco2mix, aes(as.numeric(date), solar)) %>%
  v_scale_x_date(date_breaks = 10)


vline(eco2mix, aes(as.numeric(date), solar)) %>%
  v_scale_x_date(date_breaks = "2 years")


vline(eco2mix, aes(as.numeric(date), solar)) %>%
  v_scale_x_date(date_labels = "%m-%Y")


vline(eco2mix, aes(as.numeric(date), solar)) %>%
  v_scale_x_date(date_labels = "%b %Y")


vline(eco2mix, aes(as.numeric(date), solar)) %>%
  v_scale_x_date(date_labels = d3_format_time("%b %Y", locale = "fr-FR"))
