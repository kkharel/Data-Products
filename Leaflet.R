# Leaflet is JS library, have package to create interactive maps within R


crimedata = read.csv('C:\\Users\\kkhar\\OneDrive\\Documents\\Data_Products\\Data-Products\\CrimeRate2022.csv', header = TRUE)

US_States = data.frame(names = crimedata$ï..States,
                       pop = crimedata$pop2020,
                       crimes = crimedata$reported,
                       violent = crimedata$violent,
                       nonviolent = crimedata$nonViolent,
                       latitude = crimedata$Latitude,
                       longitude = crimedata$Longitude)
US_States %>%
  leaflet() %>%
  addTiles() %>%
  addCircles(weight = 1, radius = sqrt(md_cities$pop)*30) %>%
  clearBounds()
