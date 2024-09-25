
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
        "treemap", "circlepacking", "sankey", "wordcloud",
        "venn", "waterfall", "sunburst"
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
  
  my_theme <- function(vc) {
    vc %>% 
      v_theme(token = list(
        fontSize = 12,
        l1FontSize = 16,
        l2FontSize = 14, 
        l3FontSize = 12, 
        l4FontSize = 10,
        l5FontSize = 8
      ))
  }
  
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
      )) %>% 
      my_theme()
  })
  
  output$line <- renderVchart({
    vchart(eco2mix) %>% 
      v_line(aes(date, solar)) %>% 
      v_specs_datazoom() %>% 
      my_theme()
  })
  
  output$area <- renderVchart({
    vchart(eco2mix_long) %>%
      v_area(aes(date, production, fill = source), stack = TRUE) %>% 
      v_scale_y_continuous(min = -2000) %>% 
      my_theme()
  })
  
  output$area_range <- renderVchart({
    vchart(temperatures, aes(date)) %>%
      v_area(aes(ymin = low, ymax = high)) %>% 
      my_theme()
  })
  
  output$pie <- renderVchart({
    subset(world_electricity, year == 2023 & type == "total") %>%
      vchart() %>% 
      v_pie(aes(x = source, y = generation)) %>% 
      my_theme()
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
      ) %>% 
      my_theme()
  })
  
  output$scatter <- renderVchart({
    vchart(palmerpenguins::penguins) %>%
      v_scatter(
        aes(x = flipper_length_mm, y = body_mass_g, color = species)
      ) %>% 
      my_theme()
  })
  
  output$smooth <- renderVchart({
    vchart(palmerpenguins::penguins) %>%
      v_smooth(
        aes(x = flipper_length_mm, y = body_mass_g, color = species)
      ) %>% 
      my_theme()
  })
  
  output$boxplot <- renderVchart({
    vchart(palmerpenguins::penguins) %>%
      v_boxplot(
        aes(x = species, y = body_mass_g)
      ) %>% 
      my_theme()
  })
  
  output$jitter <- renderVchart({
    vchart(palmerpenguins::penguins) %>%  
      v_jitter(aes(species, bill_length_mm)) %>% 
      my_theme()
  })
  
  output$heatmap <- renderVchart({
    vchart(co2_emissions) %>%
      v_heatmap(aes(x = year, y = country, fill = co2_per_capita)) %>% 
      v_specs_legend(visible = FALSE) %>% 
      my_theme()
  })
  
  output$treemap <- renderVchart({
    vchart(countries_gdp) %>%
      v_treemap(
        aes(lvl1 = REGION_UN, lvl2 = ADMIN, value = GDP_MD),
        label = list(visible = FALSE),
        nonLeaf = list(visible = TRUE),
        nonLeafLabel = list(visible = TRUE, position = "top")
      ) %>% 
      my_theme()
  })
  
  output$circlepacking <- renderVchart({
    vchart(countries_gdp) %>%
      v_circlepacking(
        aes(lvl1 = REGION_UN, lvl2 = SUBREGION, lvl3 = ADMIN, value = GDP_MD), 
        label_visible = FALSE
      ) %>% 
      my_theme()
  })
  
  output$sankey <- renderVchart({
    vchart(energy_sankey) %>%
      v_sankey(aes(target, source, value = value)) %>% 
      my_theme()
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
      ) %>% 
      my_theme()
  })
  
  output$venn <- renderVchart({
    data.frame(
      sets = c("A", "B", "C", "A,B", "A,C", "B,C", "A,B,C"),
      value = c(8, 10, 12, 4, 4, 4, 2)
    ) %>% 
      vchart() %>% 
      v_venn(aes(sets = sets, value = value)) %>% 
      my_theme()
  })
  
  output$waterfall <- renderVchart({
    data.frame(
      desc = c("Starting Cash",
               "Sales", "Refunds", "Payouts", "Court Losses",
               "Court Wins", "Contracts", "End Cash"),
      amount = c(2000, 3400, -1100, -100, -6600, 3800, 1400, 2800)
    ) %>% 
      vchart() %>% 
      v_waterfall(aes(x = desc, y = amount)) %>% 
      my_theme()
  })
  
  output$sunburst <- renderVchart({
    vchart(countries_gdp) %>%
      v_sunburst(
        aes(lvl1 = REGION_UN, lvl2 = SUBREGION, lvl3 = ADMIN, value = GDP_MD),
        gap = 10,
        labelAutoVisible = list(
          enable = TRUE
        ),
        labelLayout = list(
          align = "center",
          rotate = "radial"
        )
      ) %>% 
      my_theme()
  })
  
}


shinyApp(ui = ui, server = server)
