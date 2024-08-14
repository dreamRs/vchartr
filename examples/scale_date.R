
library(vchartr)

# Add a title to the axis
vchart(eco2mix) %>%
  v_line(aes(date, solar)) %>%
  v_scale_x_date(name = "Date")

# Specify number of labels
vchart(eco2mix) %>%
  v_line(aes(date, solar)) %>%
  v_scale_x_date(date_breaks = 5)

# Specify intervals between labels
vchart(eco2mix) %>%
  v_line(aes(date, solar)) %>%
  v_scale_x_date(date_breaks = "2 years")

# Format labels
vchart(eco2mix) %>%
  v_line(aes(date, solar)) %>%
  v_scale_x_date(date_labels = "MM-YYYY")

# Other format for labels
vchart(eco2mix) %>%
  v_line(aes(date, solar)) %>%
  v_scale_x_date(date_labels = "MMM YYYY")

# Format labels with locale
vchart(eco2mix) %>%
  v_line(aes(date, solar)) %>%
  v_scale_x_date(
    date_labels = format_date_dayjs("MMMM YY", locale = "fr")
  )

# Different formats in labels and tootlip
vchart(eco2mix) %>%
  v_line(aes(date, solar)) %>%
  v_scale_x_date(
    date_labels = "YYYY-MM",
    date_labels_tooltip = "MMMM YYYY"
  )

