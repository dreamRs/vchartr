
if (rlang::is_installed("cranlogs")) {
  
  top_pkgs <- cranlogs::cran_top_downloads(count = 50)
  
  vwordcloud(top_pkgs, aes(word = package, count = count))
  
  vwordcloud(top_pkgs, aes(word = package, count = count, color = package))
  
  vwordcloud(top_pkgs, aes(word = package, count = count)) %>% 
    v_specs(
      wordCloudConfig = list(
        zoomToFit = list(
          enlarge = TRUE,
          fontSizeLimitMax = 30
        )
      )
    )
  
}

