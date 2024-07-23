## code to prepare `countries_gdp` dataset goes here

library(data.table)
library(rnaturalearth)

countries <- as.data.table(rnaturalearth::countries110)

unique(countries[, list(CONTINENT, SUBREGION)])[order(CONTINENT)]
unique(countries[, list(CONTINENT, REGION_WB)])[order(CONTINENT)]


unique(countries[, list(REGION_UN, SUBREGION)])[order(REGION_UN)]


countries_gdp <- countries[, list(REGION_UN, SUBREGION, ADMIN, GDP_MD)]


setDF(countries_gdp)
usethis::use_data(countries_gdp, overwrite = TRUE)
