#  ------------------------------------------------------------------------
#
# eCO2mix data
# https://www.rte-france.com/eco2mix
#
#  ------------------------------------------------------------------------


# Packages ----------------------------------------------------------------

library(data.table)
library(fasttime)
library(lubridate)




# Download data -----------------------------------------------------------

# Source: https://odre.opendatasoft.com/explore/dataset/eco2mix-national-cons-def/
# and https://odre.opendatasoft.com/explore/dataset/eco2mix-national-tr


# Read & transform data ---------------------------------------------------

eco2mix <- fread(file = "data-raw/eco2mix-national-cons-def.csv")
eco2mix <- eco2mix[, c(5, 6, 9:17)]
setnames(eco2mix, c("datetime", "consumption", "fuel", "coal", "gas", "nuclear", "wind", "solar", "hydraulic", "pumping", "bioenergies"))

eco2mix_tr <- fread(file = "data-raw/eco2mix-national-tr.csv")
eco2mix_tr <- eco2mix_tr[, c(5, 6, 9:13, 16:19)]
setnames(eco2mix_tr, c("datetime", "consumption", "fuel", "coal", "gas", "nuclear", "wind", "solar", "hydraulic", "pumping", "bioenergies"))

# eco2mix_year <- copy(eco2mix_tr)
eco2mix <- rbind(eco2mix, eco2mix_tr)
eco2mix <- eco2mix[!is.na(consumption)]
eco2mix[, consumption := NULL]
setorder(eco2mix, datetime)
eco2mix[, datetime := with_tz(datetime, "Europe/Paris")]


eco2mix[, solar := as.numeric(solar)]
eco2mix[, hydraulic := as.numeric(hydraulic)]

# eco2mix <- eco2mix[year(datetime) >= 2012] #  & mday(datetime) == 1
eco2mix <- eco2mix[, lapply(.SD, function(x) round(mean(x, na.rm = TRUE))), by = list(date = as.Date(format(datetime, "%Y-%m-01")))]



eco2mix_long <- melt(
  data = eco2mix,
  id.vars = 1,
  variable.name = "source",
  value.name = "production",
  na.rm = TRUE,
  variable.factor = FALSE
)
setorder(eco2mix_long, source, date)


eco2mix_long[]
eco2mix[]


vline(eco2mix, aes(date, wind))
vline(eco2mix, aes(date, nuclear))
vline(eco2mix, aes(date, solar))
vline(eco2mix, aes(date, hydraulic))
vline(eco2mix, aes(date, wind))


# Use data ----------------------------------------------------------------

setDF(eco2mix)
usethis::use_data(eco2mix, internal = FALSE, overwrite = TRUE, compress = "xz")

