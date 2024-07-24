
library(vchartr)

# Configure some options for axes
vline(NULL, aes(x = month.name, y = sample(5:25, 12))) %>% 
  v_axes(
    position = "left",
    title = list(
      visible = TRUE,
      text = "Y axis title",
      position = "start"
    ),
    label = list(
      formatMethod = JS("val => `${val}°C`")
    ),
    domainLine = list(
      visible = TRUE,
      style = list(stroke = "#000")
    ),
    tick = list(
      visible = TRUE,
      tickStep = 2,
      tickSize = 6,
      style = list(stroke = "#000")
    ),
    grid = list(
      visible = TRUE,
      style = list(lineDash = list(0), stroke = "#6E6E6E", zIndex = 100)
    )
  )%>% 
  v_axes(
    position = "bottom",
    title = list(
      visible = TRUE,
      text = "X axis title",
      position = "end"
    ),
    domainLine = list(
      visible = TRUE,
      style = list(stroke = "#000")
    ),
    tick = list(
      visible = TRUE,
      tickStep = 2,
      tickSize = 6,
      style = list(stroke = "#000")
    ),
    grid = list(
      visible = TRUE,
      style = list(lineDash = list(0)),
      alternateColor = c("#F2F2F2", "#FFFFFF"),
      alignWithLabel = TRUE
    )
  )



# By default vline add an axe on the left
vline(NULL, aes(x = month.name, y = sample(5:25, 12))) %>% 
  v_axes(position = "left", remove = TRUE) %>% 
  v_axes(position = "right", type= "linear")

# Use secondary axes
vline(NULL, aes(x = month.name, y = sample(5:25, 12)), serie_id = "serie_left") %>%
  v_add_line(aes(x = month.name, y = sample(5:25 * 100, 12)), serie_id = "serie_right") %>% 
  v_axes(position = "left", seriesId = "serie_left") %>% 
  v_axes(position = "right", type = "linear", seriesId = "serie_right")

