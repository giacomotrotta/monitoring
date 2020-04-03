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


