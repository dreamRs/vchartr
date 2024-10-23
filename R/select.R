

v_default_select <- function(vc,
                             mapdata,
                             data_id,
                             ...) {
  mapdata <- split(mapdata, as.character(mapdata$select))
  vc$x$select <- list(
    dataId = data_id,
    data = mapdata,
    config = list(
      data = lapply(
        X = names(mapdata),
        FUN = function(x) {
          list(text = x, value = x)
        }
      )
    )
  )
  return(vc)
}

