
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



#' @title World low carbon & fossil generation 2014 - 2023
#'
#' @description This dataset represents world's electricity generation from low-carbon sources and fossil fuels over the period 2014 - 2023.
#'
#' @format A data frame with 20 observations and 3 variables:
#'   * `year` : Year
#'   * `source` : Either :
#'     + `Low carbon` : Electricity generation from low-carbon sources - Low-carbon sources correspond to renewables and nuclear power, that produce significantly less greenhouse-gas emissions than fossil fuels.
#'     + `Fossil` : Electricity generation from fossil fuels
#'   * `generation` : Electricity generation in terawatt-hours.
#'
#' @source [Our World In Data](https://github.com/owid/energy-data)
"world_generation"



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
#' @source [Enedis](https://data.enedis.fr/explore/dataset/donnees-de-temperature-et-de-pseudo-rayonnement/)
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

