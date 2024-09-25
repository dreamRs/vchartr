
library(shiny)
library(bslib)
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
