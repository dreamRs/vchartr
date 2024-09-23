
library(vchartr)

data.frame(month = month.abb, value = sample(1:50, 12)) %>% 
  vchart() %>% 
  v_line(aes(month, value)) %>% 
  v_specs_crosshair(
    xField = list(
      visible = TRUE,
      line = list(type = "rect"), 
      defaultSelect = list(
        axisIndex = 0, 
        datum = "May"
      ), 
      label = list(visible = TRUE)
    ), 
    yField = list(
      visible = TRUE, 
      defaultSelect = list(
        axisIndex = 1,
        datum = 30
      ), 
      line = list(
        style = list(
          lineWidth = 1, 
          opacity = 1, 
          stroke = "#000", 
          lineDash = c(2, 2)
        )
      ),
      label = list(visible = TRUE)
    )
  )

