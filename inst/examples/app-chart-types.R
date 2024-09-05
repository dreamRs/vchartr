
library(shiny)
library(bslib)
library(vchartr)


ui <- page_fluid(
  theme = bs_theme(preset = "bootstrap", bg = "#E6E7E7", fg = "#2E2E2E"),
  
  tags$h1("VChart types examples", class = "text-center"),
  
  tags$div(
    class = "row row-cols-md-3 g-2 m-auto w-75 mb-5",
    
    lapply(
      X = c(
        "bar", "line", "area", "area_range", "pie", "hist", 
        "scatter", "smooth", "boxplot", "jitter", "heatmap",
        "treemap", "circlepacking", "sankey", "wordcloud"
      ),
      FUN = function(type) {
        tags$div(
          class = "col",
          tags$div(
            class = "card",
            vchartOutput(outputId = type, height = "250px")
          )
        )
      }
    )
    
  )
  
)


server <- function(input, output, session) {
  
  output$bar <- renderVchart({
    electricity_mix %>% 
      subset(country %in% c("France", "South Korea")) %>% 
      vchart() %>% 
      v_bar(aes(country, generation, fill = source)) %>%
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
  
  output$line <- renderVchart({
    vchart(eco2mix) %>% 
      v_line(aes(date, solar)) %>% 
      v_specs_datazoom()
  })
  
  output$area <- renderVchart({
    vchart(eco2mix_long) %>%
      v_area(aes(date, production, fill = source), stack = TRUE) %>% 
      v_scale_y_continuous(min = -2000)
  })
  
  output$area_range <- renderVchart({
    vchart(temperatures, aes(date)) %>%
      v_area(aes(ymin = low, ymax = high))
  })
  
  output$pie <- renderVchart({
    subset(world_electricity, year == 2023 & type == "total") %>%
      vchart() %>% 
      v_pie(aes(x = source, y = generation))
  })
  
  output$hist <- renderVchart({
    vchart(palmerpenguins::penguins) %>%
      v_hist(
        aes(flipper_length_mm),
        bar = list(
          style = list(
            stroke = "white",
            line_width = 1,
            fill = "forestgreen"
          )
        )
      )
  })
  
  output$scatter <- renderVchart({
    vchart(palmerpenguins::penguins) %>%
      v_scatter(
        aes(x = flipper_length_mm, y = body_mass_g, color = species)
      )
  })
  
  output$smooth <- renderVchart({
    vchart(palmerpenguins::penguins) %>%
      v_smooth(
        aes(x = flipper_length_mm, y = body_mass_g, color = species)
      )
  })
  
  output$boxplot <- renderVchart({
    vchart(palmerpenguins::penguins) %>%
      v_boxplot(
        aes(x = species, y = body_mass_g)
      )
  })
  
  output$jitter <- renderVchart({
    vchart(palmerpenguins::penguins) %>%  
      v_jitter(aes(species, bill_length_mm))
  })
  
  output$heatmap <- renderVchart({
    vchart(co2_emissions) %>%
      v_heatmap(aes(x = year, y = country, fill = co2_per_capita))
  })
  
  output$treemap <- renderVchart({
    vchart(countries_gdp) %>%
      v_treemap(
        aes(lvl1 = REGION_UN, lvl2 = ADMIN, value = GDP_MD),
        label = list(visible = FALSE),
        nonLeaf = list(visible = TRUE),
        nonLeafLabel = list(visible = TRUE, position = "top")
      )
  })
  
  output$circlepacking <- renderVchart({
    vchart(countries_gdp) %>%
      v_circlepacking(
        aes(lvl1 = REGION_UN, lvl2 = SUBREGION, lvl3 = ADMIN, value = GDP_MD), 
        label_visible = FALSE
      )
  })
  
  output$sankey <- renderVchart({
    vchart(energy_sankey) %>%
      v_sankey(aes(target, source, value = value))
  })
  
  output$wordcloud <- renderVchart({
    vchart(top_cran_downloads) %>%
      v_wordcloud(
        aes(word = package, count = count, color = package),
        wordCloudConfig = list(
          zoomToFit = list(
            shrink = TRUE,
            fontSizeLimitMin = 7
          )
        )
      )
  })
  
}


shinyApp(ui = ui, server = server)
