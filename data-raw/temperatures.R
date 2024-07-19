#  ------------------------------------------------------------------------
#
# temperature data for France
# https://data.enedis.fr/explore/dataset/donnees-de-temperature-et-de-pseudo-rayonnement
#
#  ------------------------------------------------------------------------


# Packages ----------------------------------------------------------------

library(data.table)
library(fasttime)


# Data --------------------------------------------------------------------

temperatures <- fread(file = "data-raw/donnees-de-temperature-et-de-pseudo-rayonnement.csv")
temperatures <- temperatures[, c(6, 7, 8, 2)]
setnames(temperatures, c("year", "month", "day", "temperature"))
# temperatures <- temperatures[year > 2017]
temperatures <- temperatures[, list(temperature = round(mean(temperature, na.rm = TRUE), 1)), by = c("year", "month", "day")]
temperatures <- dcast(data = temperatures, formula = month + day ~ year, value.var = "temperature")
# temperatures <- temperatures[!(month == 2 & day == 29)]

temperatures[, low := do.call(pmin, c(as.list(.SD), na.rm = TRUE)), .SDcols = as.character(2019:2023)]
temperatures[, high := do.call(pmax, c(as.list(.SD), na.rm = TRUE)), .SDcols = as.character(2019:2023)]
temperatures[, average := rowMeans(.SD, na.rm = TRUE), .SDcols = as.character(2019:2023)]
temperatures[, (as.character(2019:2023)) := NULL]
# setnames(temperatures, "2022", "temperature")

temperatures[, date := as.Date(paste(2024, month, day, sep = "-"))]
temperatures[, (c("month", "day")) := NULL]
setcolorder(temperatures, "date")

temperatures[]


# Save --------------------------------------------------------------------

setDF(temperatures)
usethis::use_data(temperatures, internal = FALSE, overwrite = TRUE, compress = "xz")




