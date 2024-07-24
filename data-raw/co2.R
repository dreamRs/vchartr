## Source : https://github.com/owid/co2-data

library(data.table)
library(rnaturalearth)
library(sf)

co2 <- fread("data-raw/owid-co2-data.csv")



# co2 emissions for subset of country -----------------------------------------------

co2[year == 2022 & iso_code != ""][order(co2, decreasing = TRUE)][1:10, list(country, co2)]
countries <- co2[year == 2022 & iso_code != ""][order(co2, decreasing = TRUE)][1:15]$country
# countries <- c(
#   "China", "United States", "India", "Russia", "Japan", "Brazil",
#   "Canada", "South Korea", "France", "Germany"
# )

co2 <- co2[country %in% countries & year >= 1990, list(
  country, year,
  co2, co2_per_gdp, co2_per_capita, co2_growth_abs, co2_growth_prct, co2_per_unit_energy,
  consumption_co2, consumption_co2_per_capita, consumption_co2_per_gdp
)]
co2[, co2_growth_change := fifelse(co2_growth_prct > 0, "Increase", "Decrease")]

setorder(co2, country, year)

co2_emissions <- as.data.frame(co2)
usethis::use_data(co2_emissions, overwrite = TRUE)




# World CO2 emissions ---------------------------------------------------------------

world_countries <- as.data.table(rnaturalearth::countries110)
co2_world <- merge(
  x = world_countries[!ISO_A3_EH %in% c("-99", "ATA", "ATF"), list(iso_code = ISO_A3_EH, geometry)],
  y = co2[year == 2022 & iso_code != "", list(name = country, iso_code, co2, co2_per_capita)],
  by = "iso_code",
  all.x = TRUE,
  all.y = FALSE
)
setDF(co2_world)
co2_world <- sf::st_as_sf(co2_world)

usethis::use_data(co2_world, overwrite = TRUE)

