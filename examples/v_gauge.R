
library(vchartr)

vchart() %>%
  v_gauge(aes("My gauge", 0.8))

vchart() %>%
  v_gauge(
    aes("My gauge", 0.8),
    gauge = list(
      type = "circularProgress",
      cornerRadius = 20,
      progress = list(
        style = list(
          fill = "forestgreen"
        )
      ),
      track = list(
        style = list(
          fill = "#BCBDBC"
        )
      )
    ),
    pointer = list(
      style = list(
        fill = "#2F2E2F"
      )
    )
  )


vchart() %>%
  v_gauge(aes("My gauge", 0.8)) %>%
  v_scale_y_continuous(labels = ".0%")
