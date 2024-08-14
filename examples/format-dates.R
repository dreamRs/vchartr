
library(vchartr)



### Format date

# date in french in %B %y format
vchart(eco2mix) %>%
  v_line(aes(date, solar)) %>%
  v_scale_x_date(
    date_labels = format_date_dayjs("MMMM YY", locale = "fr")
  )

# date in arabic in %A %d %b %Y format
vchart(eco2mix) %>%
  v_line(aes(date, solar)) %>%
  v_scale_x_date(
    date_labels = format_date_dayjs("dddd D MMM YYYY", locale = "ar")
  )
