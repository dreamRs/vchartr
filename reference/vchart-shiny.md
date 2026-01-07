# Shiny bindings for vchart

Output and render functions for using
[`vchart()`](https://dreamrs.github.io/vchartr/reference/vchart.md)
within Shiny applications and interactive Rmd documents.

## Usage

``` r
vchartOutput(outputId, width = "100%", height = "400px")

renderVchart(expr, env = parent.frame(), quoted = FALSE)
```

## Arguments

- outputId:

  output variable to read from

- width, height:

  Must be a valid CSS unit (like `"100%"`, `"400px"`, `"auto"`) or a
  number, which will be coerced to a string and have `"px"` appended.

- expr:

  An expression that generates an HTML widget (or a
  [promise](https://rstudio.github.io/promises/) of an HTML widget).

- env:

  The environment in which to evaluate `expr`.

- quoted:

  Is `expr` a quoted expression (with
  [`quote()`](https://rdrr.io/r/base/substitute.html))? This is useful
  if you want to save an expression in a variable.

## Value

An output or render function that enables the use of the widget within
Shiny applications.

## Examples

``` r
library(shiny)
library(bslib)
#> 
#> Attaching package: ‘bslib’
#> The following object is masked from ‘package:utils’:
#> 
#>     page
library(vchartr)

ui <- page_fluid(
  tags$div(
    style = "max-width: 900px; margin: auto;",
    tags$h2("vchart in shiny"),
    radioButtons(
      inputId = "data",
      label = "Show:",
      choiceNames = c("electricity mix by country", "countries generation by sources"),
      choiceValues = c("mix", "sources"),
      inline = TRUE
    ),
    conditionalPanel(
      condition = "input.data == 'mix'",
      selectInput(
        inputId = "country",
        label = "Select country:",
        choices = unique(electricity_mix$country)
      )
    ),
    conditionalPanel(
      condition = "input.data == 'sources'",
      selectInput(
        inputId = "source",
        label = "Select source:",
        choices = unique(electricity_mix$source)
      )
    ),
    vchartOutput(outputId = "mychart", height = "500px"),
    radioButtons(
      inputId = "type",
      label = "Represent as:",
      choices = c("bar", "pie", "treemap", "circlepacking"),
      inline = TRUE
    ),
    checkboxInput(
      inputId = "show_label",
      label = "Show label ?"
    )
  )
)

server <- function(input, output, session) {

  output$mychart <- renderVchart({

    if (input$data == "mix") {
      elec_data <- subset(electricity_mix, country == input$country)
      mapping <- aes(source, generation, fill = source)
    } else {
      elec_data <- subset(electricity_mix, source == input$source)
      mapping <- aes(country, generation, fill = country)
    }

    vc <- vchart(elec_data, mapping = mapping)
    if (input$type == "bar") {
      vc <- vc %>% 
        v_bar(serie_id = "bar_serie") %>%
        v_specs_legend(visible = FALSE) %>%
        v_specs(
          xField = "x",
          label = list(visible = input$show_label),
          serie_id = "bar_serie"
        )
    } else if (input$type == "pie") {
      vc <- vc %>% 
        v_pie(label = list(visible = input$show_label))
    } else if (input$type == "treemap") {
      vc <- vc %>% 
        v_treemap(label = list(visible = input$show_label))
    } else if (input$type == "circlepacking") {
      vc <- vc %>% 
        v_circlepacking(label = list(style = list(visible = input$show_label)))
    }
    vc %>%
      v_scale_color_manual(c(
        "oil" = "#80549f",
        "coal" = "#a68832",
        "solar" = "#d66b0d",
        "gas" = "#f20809",
        "wind" = "#72cbb7",
        "hydro" = "#2672b0",
        "nuclear" = "#e4a701"
      ))
  })

}

if (interactive())
  shinyApp(ui, server)
```
