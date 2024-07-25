
library(shiny)
library(bslib)

ui <- page_fluid(
  tags$div(
    style = "max-width: 900px; margin: auto;",
    tags$h2("vchart in shiny"),
    selectInput(
      inputId = "country",
      label = "Select country:",
      choices = unique(electricity_mix$country)
    ),
    vchartOutput(outputId = "mychart"),
    checkboxInput(
      inputId = "show_label",
      label = "Show label ?"
    )
  )
)

server <- function(input, output, session) {

  output$mychart <- renderVchart({
    vbar(
      subset(electricity_mix, country == input$country),
      aes(source, generation, fill = source)
    ) %>%
      v_specs(xField = "x") %>%
      v_legend(visible = FALSE) %>%
      v_specs(
        label = list(visible = input$show_label)
      ) %>%
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
