
library(vchartr)

vchart(top_generation) %>% 
  v_bar(aes(country, electricity_generation)) %>% 
  v_event(
    name = "click",
    params = list(level = "mark", type = "bar"),
    fun = JS(
      "e => {",
      " console.log(e);",
      " alert(e.datum.x);",
      "}"
    )
  )

