
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
