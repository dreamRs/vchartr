
library(vchartr)

vchart() %>%
  v_progress(aes(0.85, "My progress"))

data.frame(
  x = c(0.4, 0.3, 0.8, 0.6),
  y = paste("Course", 1:4)
) %>%
  vchart() %>%
  v_progress(
    aes(x, y),
    cornerRadius = 20,
    bandWidth = 30
  ) %>%
  v_scale_y_discrete(
    label = list(visible = TRUE),
    domainLine = list(visible = FALSE)
  )
