library(data.table)

electricity <- fread("data-raw/owid-energy-data.csv")

electricity[country == "France" & year == 2023, .SD, .SDcols = grep("electricity$", x = names(electricity), value = TRUE)]


electricity[country == "France" & year == 2023, list(electricity_generation, renewables_electricity, low_carbon_electricity, fossil_electricity)]

electricity[year == 2023 & iso_code != ""][order(-electricity_generation)][1:5, list(country, electricity_generation)]

melt(
  data = electricity[country == "World" & year == 2023],
  id.vars = c("country", "year"),
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
) %>%
  vbar(aes(variable, value))


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



