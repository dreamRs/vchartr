

# Météo Paris -----------------------------------------------------------------------

library(rvest)

tableaux <- read_html("https://fr.climate-data.org/europe/france/ile-de-france/paris-44/#climate-table") %>% 
  html_table()

meteo_paris <- tableaux[[1]]
dput(names(meteo_paris))
c("", "Température moyenne (°C)", "Température minimale moyenne (°C)", 
  "Température maximale (°C)", "Précipitations (mm)", "Humidité (%)", 
  "Jours de pluie (jrée)", "Heures de soleil (h)")

names(meteo_paris) <- c("month", "temperature_avg", "temperature_min", "temperature_max", "precipitation", "humidity", "rainy_days", "sunshine_hours")
meteo_paris$month <- month.name
meteo_paris$humidity <- as.numeric(gsub("%", "", meteo_paris$humidity)) / 100

meteo_paris <- as.data.frame(meteo_paris)

usethis::use_data(meteo_paris, overwrite = TRUE)
