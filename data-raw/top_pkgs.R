## code to prepare `top_pkgs` dataset goes here

top_cran_downloads <- cranlogs::cran_top_downloads(count = 100, when = "last-month")

usethis::use_data(top_cran_downloads, overwrite = TRUE)
