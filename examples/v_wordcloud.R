
library(vchartr)

vchart(top_cran_downloads) %>%
  v_wordcloud(aes(word = package, count = count))

vchart(top_cran_downloads) %>%
  v_wordcloud(aes(word = package, count = count, color = package))

vchart(top_cran_downloads) %>%
  v_wordcloud(
    aes(word = package, count = count, color = package),
    wordCloudConfig = list(
      zoomToFit = list(
        enlarge = TRUE,
        fontSizeLimitMax = 30
      )
    )
  )
