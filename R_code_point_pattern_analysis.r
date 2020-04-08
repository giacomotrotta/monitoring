#point pattern analysis: density map

install.packages("spatstat")
library(spatstat)

attach(covid)
head(covid)

covids <- ppp(lon, lat, c(-180,180), c(-90,90)) #c da i range delle variabili 

?ppp #da info su cosa posso scrivere in ppp

#se non voglio attaccare covid basta aggiungere covid$ a ogni variabile, es covid$lon

d <- density(covids) #mappa costruita prossimo passaggio la mostro

plot(d)
points(covids) #devo tenere la finestra del grafico aperto altrimenti non va

#nuovalezione

#carico la vecchia sessione
load("/Users/giacomotrotta/lab/R_code_spatial.RData")
setwd("Users/giacomotrotta/lab")
library(spatstat)
plot(d)
points(covids)

#ora aggiungo le linee di costa per vedere la mappa rapportata ai territori
install.packages("rgdal")
library(rgdal)

#ora importo le coastline. è strutturata così ad esempio (x0y0,x1y1...)

coastlines <- readOGR("ne_10m_coastline.shp") #OGR in maiuscolo altrimenti non funziona

plot(d)
points(covids)
plot(coastlines, add=T) #add means add the line to the previous image

#change of the colour
cl <- colorRampPalette(c("yellow", "orange", "red")) (100) 
#decido quali saranno i colori relativi alla più alta densità e alla più bassa
#sopra va dal giallo al rosso, il 100 indica che mette. 100 colori tra il giallo e il rosso (gradazione)

plot(d, col=cl, main="Density of covid-19") #assegno come colore l'oggetto cl che è associato a una funzionae di colori
points(covids)
plot(coastlines, add=T)

#exercise: new colour ramp palette
cl2 <- colorRampPalette(c("light green", "yellow", "orange", "red")) (100) #posso mettere quanti colori voglio

#export this map in PDF
pdf("covid_density.pdf")
cl2 <- colorRampPalette(c("light green", "yellow", "orange", "red")) (100)
plot(d, col=cl2, main="Density of covid-19") 
points(covids)
plot(coastlines, add=T)
dev.off() #chiudo la finestra così ho il pdf. posso fare la stessa cosa col png
#pdf è meglio, non rovina la qualità dell'immagine

png("covid_density.png")
cl2 <- colorRampPalette(c("light green", "yellow", "orange", "red")) (100)
plot(d, col=cl2, main="Density of covid-19") 
points(covids)
plot(coastlines, add=T)
dev.off()






