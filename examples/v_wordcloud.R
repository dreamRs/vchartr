
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


if (interactive()) {
  # Use an image to shape the wordcloud
  vchart(top_cran_downloads) %>%
    v_wordcloud(
      aes(word = package, count = count, color = package),
      maskShape = "https://jeroen.github.io/images/Rlogo.png"
    )
}
