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

world_generation <- melt(
  data = electricity[year %in% c(2014:2023) & country == "World", list(year, low_carbon_electricity, fossil_electricity)],
  id.vars = "year",
  measure.vars = c("low_carbon_electricity", "fossil_electricity"),
  variable.name = "source",
  variable.factor = FALSE,
  value.name = "generation"
)
world_generation[source == "low_carbon_electricity", source := "Low carbon"]
world_generation[source == "fossil_electricity", source := "Fossil fuels"]

setDF(world_generation)
usethis::use_data(world_generation, overwrite = TRUE)



