
#' @title Top electricity-generating countries
#'
#' @description This dataset represents the 10 countries with the highest electricity generation in 2023.
#'
#' @format A data frame with 10 observations and 2 variables:
#'   * `country` : Country name
#'   * `electricity_generation` : Total electricity generation - Measured in terawatt-hours.
#'
#' @source [Our World In Data](https://github.com/owid/energy-data)
"top_generation"




#' @title Electricity mix for 10 countries
#'
#' @description This dataset represents the electricity mix of 10 countries (those with the highest electricity generation) in 2023.
#'
#' @format A data frame with 70 observations and 3 variables:
#'   * `country` : Country name
#'   * `source` : source of electricity
#'   * `generation` : Total electricity generation - Measured in terawatt-hours.
#'   * `type` : Low carbon or fossil fuels type of source.
#'
#' @source [Our World In Data](https://github.com/owid/energy-data)
"electricity_mix"



#' @title World low carbon & fossil electricity generation 2014 - 2023
#'
#' @description This dataset represents world's electricity generation from low-carbon sources and fossil fuels over the period 2014 - 2023.
#'
#' @format A data frame with 70 observations and 4 variables:
#'   * `year` : Year
#'   * `source` : Either :
#'     + `Low carbon` : Electricity generation from low-carbon sources -
#'       Low-carbon sources correspond to renewables and nuclear power, that produce significantly less greenhouse-gas emissions than fossil fuels.
#'     + `Renewables` : Electricity generation from renewables
#'     + `Nuclear` : Electricity generation from nuclear
#'     + `Fossil` : Electricity generation from fossil fuels (oil + gas + coal)
#'     + `Oil` : Electricity generation from fossil fuels
#'     + `Gas` : Electricity generation from fossil fuels
#'     + `Coal` : Electricity generation from fossil fuels
#'   * `generation` : Electricity generation in terawatt-hours.
#'   * `type` : Type of source : total or detail.
#'
#' @source [Our World In Data](https://github.com/owid/energy-data)
"world_electricity"



#' @title CO2 emissions
#'
#' @description This dataset represents CO2 emissions for a subset of country over the period 1990 - 2022.
#'
#' @format A data frame with 495 observations and 11 variables:
#'   * `country` : Country - Geographic location.
#'   * `year` : Year - Year of observation.
#'   * `co2` : Annual CO2 emissions - Annual total emissions of carbon dioxide (CO2), excluding land-use change, measured in million tonnes.
#'   * `co2_per_gdp` : Annual CO2 emissions per GDP (kg per international-$) - Annual total emissions of carbon dioxide (CO2), excluding land-use change, measured in kilograms per dollar of GDP (2011 international-$).
#'   * `co2_per_capita` : Annual CO2 emissions (per capita) - Annual total emissions of carbon dioxide (CO2), excluding land-use change, measured in tonnes per person.
#'   * `co2_growth_abs` : Annual CO2 emissions growth (abs) - Annual growth in total emissions of carbon dioxide (CO2), excluding land-use change, measured in million tonnes.
#'   * `co2_growth_prct` : Annual CO2 emissions growth (%) - Annual percentage growth in total emissions of carbon dioxide (CO2), excluding land-use change.
#'   * `co2_per_unit_energy` : Annual CO2 emissions per unit energy (kg per kilowatt-hour) - Annual total emissions of carbon dioxide (CO2), excluding land-use change, measured in kilograms per kilowatt-hour of primary energy consumption.
#'   * `consumption_co2` : Annual consumption-based CO2 emissions - Annual consumption-based emissions of carbon dioxide (CO2), measured in million tonnes.
#'   * `consumption_co2_per_capita` : Per capita consumption-based CO2 emissions - Annual consumption-based emissions of carbon dioxide (CO2), measured in tonnes per person.
#'   * `consumption_co2_per_gdp` : Annual consumption-based CO2 emissions per GDP (kg per international-$) - Annual consumption-based emissions of carbon dioxide (CO2), measured in kilograms per dollar of GDP (2011 international-$).
#'
#' @note
#' Documentation is from Our World In Data, see [https://github.com/owid/co2-data](https://github.com/owid/co2-data) for the data
#'  and [https://ourworldindata.org/co2-and-greenhouse-gas-emissions](https://ourworldindata.org/co2-and-greenhouse-gas-emissions) for more about CO2 emissions.
#'
#' @source [Our World In Data](https://github.com/owid/co2-data)
"co2_emissions"



#' @title World CO2 emissions
#'
#' @description This dataset contains world polygons with CO2 emissions.
#'
#' @format A data frame with 495 observations and 11 variables:
#'   * `iso_code` : ISO code A3 for country.
#'   * `name` : Name of country.
#'   * `co2` : Annual CO2 emissions - Annual total emissions of carbon dioxide (CO2), excluding land-use change, measured in million tonnes.
#'   * `co2_per_capita` : Annual CO2 emissions (per capita) - Annual total emissions of carbon dioxide (CO2), excluding land-use change, measured in tonnes per person.
#'   * `geometry` : Geographical attributes.
#'
#' @note
#' Documentation is from Our World In Data, see [https://github.com/owid/co2-data](https://github.com/owid/co2-data) for the data
#'  and [https://ourworldindata.org/co2-and-greenhouse-gas-emissions](https://ourworldindata.org/co2-and-greenhouse-gas-emissions) for more about CO2 emissions.
#'
#' @source [Our World In Data](https://github.com/owid/co2-data)
"co2_world"



#' @title Monthly electricity generation by source in France
#'
#' @description This dataset represents monthly electricity generation by source in France over the period 2012 - 2024.
#'
#' @format A data frame with 151 observations and 10 variables:
#'   * `date` : Date
#'   * `fuel` : Fuel generation in MW
#'   * `coal` : Coal generation in MW
#'   * `gas` : Gas generation in MW
#'   * `nuclear` : Nuclear generation in MW
#'   * `wind` : Wind generation in MW
#'   * `solar` : Solar generation in MW
#'   * `hydraulic` : Hydraulic generation in MW
#'   * `pumping` : Pumping generation in MW
#'   * `bioenergies` : Bioenergies generation in MW
#'
#' @source [eco2mix](https://odre.opendatasoft.com/explore/dataset/eco2mix-national-cons-def/)
"eco2mix"


#' @title Monthly electricity generation by source in France (long format)
#'
#' @description This dataset represents monthly electricity generation by source in France over the period 2012 - 2024.
#'
#' @format A data frame with 1359 observations and 3 variables:
#'   * `date` : Date
#'   * `source` : Production according to the different sectors making up the energy mix.
#'   * `production` : Generation in MW
#'
#' @source [eco2mix](https://odre.opendatasoft.com/explore/dataset/eco2mix-national-cons-def/)
"eco2mix_long"




#' @title Temperature data
#'
#' @description The dataset contains data about temperatures in France between 2018 and 2022.
#'
#' @format A data frame with 365 observations and 6 variables.
#'
#' @source [Enedis](https://opendata.enedis.fr/datasets/donnees-de-temperature-et-de-pseudo-rayonnement/)
"temperatures"




#' @title Countries GDP
#'
#' @description These data represent the GDP of the world's countries, classified by continent and sub-region.
#'  This is a subset of the dataset `rnaturalearth::countries110`.
#'
#' @format A data frame with 177 observations and 3 variables:
#'   * `REGION_UN` : Continent
#'   * `SUBREGION` : Sub-region in the continent
#'   * `ADMIN` : Administrative name of country
#'   * `GDP_MD` : GDP
#'
#' @source Package [rnaturalearth](https://github.com/ropensci/rnaturalearth)
"countries_gdp"



#' @title Data for Sankey Chart
#'
#' @description These data represent how energy is converted or transmitted before being consumed or lost.
#'
#' @format A data frame with 177 observations and 3 variables:
#'   * `source` : Source
#'   * `target` : Target
#'   * `value` : Energy in TWh
#'
#' @source Department of Energy & Climate Change via Tom Counsell
"energy_sankey"




#' @title Top CRAN downloads
#'
#' @description The dataset contains data about CRAN downloads retrieved with [cranlogs::cran_top_downloads](https://r-hub.github.io/cranlogs/).
#'
#' @format A data frame with 100 observations and 5 variables.
#'
#' @source [cranlogs](https://r-hub.github.io/cranlogs/)
"top_cran_downloads"



#' @title Paris climate
#'
#' @description This data contains information about the climate in Paris, France.
#'
#' @format A data frame with 177 observations and 3 variables:
#'   * `month` : Month of the year
#'   * `temperature_avg` : Average temperature (°C)
#'   * `temperature_min` : Average minimum temperature (°C)
#'   * `temperature_max` : Average maximum temperature (°C)
#'   * `precipitation` : Precipitation (mm)
#'   * `humidity` : Humidity (%)
#'   * `rainy_days` : Rainy days (days)
#'   * `sunshine_hours` : Sunshine hours (h)
#'
#' @source [Climate-data.org](https://fr.climate-data.org/europe/france/ile-de-france/paris-44/#climate-table)
"meteo_paris"
