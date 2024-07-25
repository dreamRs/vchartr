library(data.table)

electricity <- fread("data-raw/owid-energy-data.csv")
co2 <- fread("data-raw/owid-co2-data.csv")



electricity[country == "France" & year == 2023, .SD, .SDcols = grep("electricity$", x = names(electricity), value = TRUE)]


electricity[country == "France" & year == 2023, list(electricity_generation, renewables_electricity, low_carbon_electricity, fossil_electricity)]

electricity[year == 2023 & iso_code != ""][order(-electricity_generation)][1:5, list(country, electricity_generation)]

melt(
  data = electricity[country %in% c("China", "United States", "India") & year == 2023],
  id.vars = c("country"),
  measure.vars = c(
    "biofuel_electricity",
    "coal_electricity",
    "gas_electricity",
    "hydro_electricity",
    "nuclear_electricity",
    "oil_electricity",
    "other_renewable_electricity",
    "other_renewable_exc_biofuel_electricity",
    "solar_electricity",
    "wind_electricity"
  )
)



vbar(
  electricity[year == 2023 & iso_code != ""][order(-electricity_generation)][1:7, list(country, electricity_generation)],
  aes(country, electricity_generation)
)


melt(
  data = electricity[year %in% c(2014:2023) & country == "World", list(year, low_carbon_electricity, fossil_electricity)],
  id.vars = "year",
  measure.vars = c("low_carbon_electricity", "fossil_electricity"),
  variable.name = "source",
  variable.factor = FALSE,
  value.name = "generation"
) %>%
  vbar(aes(year, generation, fill = source), stack = TRUE, percent = TRUE)



co2[country == "World" & year >= 2000, list(year, co2_growth_abs)]

top_low_carbon <- melt(
  data = co2[country %in% top_generation$country & year >= 1990], #year %in% seq(1950, 2020, by = 5)
  id.vars = c("country", "year"),
  # measure.vars = "low_carbon_share_elec",#"low_carbon_elec_per_capita",
  measure.vars = "co2_per_capita",
  value.name = "low_carbon"
)

pkgload::load_all()
data <- as.data.frame(top_low_carbon)
mapping <- aes(x = year, y = country, fill = low_carbon)
mapdata <- eval_mapping(data, mapping)

vchart(
  type = "common",
  data = list(
    list(
      id = "heatmap_data",
      values = create_values(mapdata)
    )
  ),
  series = list(
    list(
      type = "heatmap",
      dataId = "heatmap_data",
      xField = "x",
      yField = "y",
      valueField = "fill",
      cell = list(
        style = list(
          fill = list(field = "fill", scale = "color")
        )
      )
    )
  ),
  axes = list(
    list(
      orient = "bottom",
      type = "band",
      grid = list(visible = FALSE),
      domainLine = list(visible = FALSE)
    ),
    list(
      orient = "left",
      type = "band",
      grid = list(visible = FALSE),
      domainLine = list(visible = FALSE)
    )
  ),
  color = list(
    type = "linear",
    domain = list(
      list(dataId = "heatmap_data", fields = list("fill"))
    ),
    # range = c(
    #   "#440154", "#482878", "#3E4A89", "#31688E", "#26828E",
    #   "#1F9E89", "#35B779", "#6DCD59", "#B4DE2C", "#FDE725"
    # )
    range = rev(
      c("#8C510A", "#BF812D", "#DFC27D", "#F6E8C3",
        "#C7EAE5", "#80CDC1", "#35978F", "#01665E")
    )
  ),
  legends = list(
    visible = TRUE,
    type = "color",
    field = "fill"
  )
)




co2_growth <- melt(
  data = co2[country %in% top_generation$country & year >= 1990], #year %in% seq(1950, 2020, by = 5)
  id.vars = c("country", "year"),
  # measure.vars = "low_carbon_share_elec",#"low_carbon_elec_per_capita",
  measure.vars = "co2_growth_prct",
  value.name = "co2_growth_prct"
)
co2_growth[, co2_growth_change := fifelse(co2_growth_prct > 0, "Increase", "Decrease")]

data <- as.data.frame(co2_growth)
mapping <- aes(x = year, y = country, fill = co2_growth_change)
mapdata <- eval_mapping(data, mapping)

vchart(
  type = "common",
  data = list(
    list(
      id = "heatmap_data",
      values = create_values(mapdata)
    )
  ),
  series = list(
    list(
      type = "heatmap",
      dataId = "heatmap_data",
      xField = "x",
      yField = "y",
      valueField = "fill",
      cell = list(
        style = list(
          fill = list(field = "fill", scale = "color")
        )
      )
    )
  ),
  axes = list(
    list(
      orient = "bottom",
      type = "band",
      grid = list(visible = FALSE),
      domainLine = list(visible = FALSE)
    ),
    list(
      orient = "left",
      type = "band",
      grid = list(visible = FALSE),
      domainLine = list(visible = FALSE)
    )
  ),
  color = list(
    type = "ordinal",
    specified = list("Increase" = "firebrick", "Decrease" = "forestgreen")
  ),
  legends = list(
    visible = TRUE,
    type = "discrete",
    field = "fill"
  )
)


vchart(
  type = "heatmap",
  data = list(
    list(
      id = "heatmap_data",
      values = create_values(mapdata)
    )
  ),
  xField = "x",
  yField = "y",
  valueField = "fill",
  cell = list(
    style = list(
      fill = list(field = "fill", scale = "color")
    )
  ),
  axes = list(
    list(
      orient = "bottom",
      type = "band",
      grid = list(visible = FALSE),
      domainLine = list(visible = FALSE)
    ),
    list(
      orient = "left",
      type = "band",
      grid = list(visible = FALSE),
      domainLine = list(visible = FALSE)
    )
  ),
  color = list(
    type = "ordinal"
    # specified = list("Increase" = "firebrick", "Decrease" = "forestgreen")
  ),
  # scales = list(
  #   list(
  #     domain = c("Increase", "Decrease"),
  #     type = "ordinal",
  #     id = "color",
  #     range = c("firebrick", "forestgreen")
  #   )
  # ),
  legends = list(
    visible = TRUE,
    type = "discrete",
    field = "fill",
    scaleName = "color"
  )
)
