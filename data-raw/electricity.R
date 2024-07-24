## Source : https://github.com/owid/energy-data
## and : https://github.com/owid/co2-data

library(data.table)

electricity <- fread("data-raw/owid-energy-data.csv")
# co2 <- fread("data-raw/owid-co2-data.csv")




# Top electricity-generating countries ------------------------------------

top_generation <- electricity[year == 2023 & iso_code != ""][order(-electricity_generation)][1:10, list(country, electricity_generation)]
vbar(top_generation, aes(country, electricity_generation))
vbar(top_generation, aes(country, electricity_generation), direction = "h")

setDF(top_generation)
usethis::use_data(top_generation, overwrite = TRUE)





# World low carbon & fossil generation 2014 - 2023 ------------------------

world_electricity <- melt(
  data = electricity[year %in% c(2014:2023) & country == "World"],
  id.vars = "year",
  measure.vars = c(
    "low_carbon_electricity",
    "renewables_electricity", "nuclear_electricity", 
    "fossil_electricity",
    "oil_electricity", "gas_electricity", "coal_electricity"
  ),
  variable.name = "source",
  variable.factor = FALSE,
  value.name = "generation"
)

world_electricity[, type := fifelse(source %in% c("low_carbon_electricity", "fossil_electricity"), "total", "detail")]

world_electricity[, source := fcase(
  source == "low_carbon_electricity", "Low carbon",
  source == "renewables_electricity", "Renewables",
  source == "nuclear_electricity", "Nuclear",
  source == "fossil_electricity", "Fossil fuels",
  source == "oil_electricity", "Oil",
  source == "gas_electricity", "Gas",
  source == "coal_electricity", "Coal"
)]

setDF(world_electricity)
usethis::use_data(world_electricity, overwrite = TRUE)



