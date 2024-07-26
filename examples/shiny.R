
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
      choiceNames = c("electricity mix by country", "coutries generation by sources"),
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

    if (input$type == "bar") {
      vc <- vbar(elec_data, mapping) %>%
        v_specs(xField = "x") %>%
        v_legend(visible = FALSE) %>%
        v_specs(
          label = list(visible = input$show_label)
        )
    } else if (input$type == "pie") {
      vc <- vpie(elec_data, mapping, serie_id = "pie"
      ) %>%
        v_specs(
          label = list(visible = input$show_label),
          serie = "pie"
        )
    } else if (input$type == "treemap") {
      vc <- vtreemap(elec_data, mapping) %>%
        v_specs(
          label = list(visible = input$show_label)
        )
    } else if (input$type == "circlepacking") {
      vc <- vcirclepacking(elec_data, mapping) %>%
        v_specs(
          label = list(style = list(visible = input$show_label))
        )
    }

    vc %>%
      v_colors_manual(
        "oil" = "#80549f",
        "coal" = "#a68832",
        "solar" = "#d66b0d",
        "gas" = "#f20809",
        "wind" = "#72cbb7",
        "hydro" = "#2672b0",
        "nuclear" = "#e4a701"
      )
  })

}

if (interactive())
  shinyApp(ui, server)
