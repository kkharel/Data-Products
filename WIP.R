library(leaflet)
crimedata = read.csv('C:\\Users\\kkhar\\OneDrive\\Documents\\Data_Products\\Data-Products\\CrimeRate2022.csv', header = TRUE)

US_States = data.frame(names = crimedata$ï..States,
                       pop = crimedata$pop2020,
                       crimes = crimedata$Crimes,
                       reported = crimedata$reported,
                       violent = crimedata$violent,
                       nonviolent = crimedata$nonViolent,
                       latitude = crimedata$Latitude,
                       longitude = crimedata$Longitude)

library(dplyr)

my_popups = US_States %>%
  group_by(names, crimes) %>%
  mutate(popup = paste0("<h3>",
                        names,
                        "</h3><br>",
                        paste("Population:", pop, "Crimes", crimes, "Reported:", reported, "Violent:", violent, "Non-Violent:", nonviolent, collapse = "<br>"))) %>%

  pull(popup)
my_popups
library(leaflet)
library(leaflet.minicharts)
library(htmltools)

tilesURL <- "http://server.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}"

colors <- c('blue','green','red','orange')

US_States %>%
  leaflet() %>%
  addTiles() %>%
  setView(-98.483330, 38.712046, zoom = 3) %>%
  addMinicharts(lat = US_States$latitude, lng = US_States$longitude, type = "bar",
                chartdata = US_States[, c("crimes", "reported", "violent", "nonviolent")],
                colorPalette = colors,
                popup = popupArgs(labels=c("crimes", "reported", "violent", "nonviolent"), html = my_popups))


