#Species distribution modelling

install.packages("sdm")

library(sdm)
library(raster) #predictors
library(rgdal) #species

file <- system.file("external/species.shp", package="sdm") f
species <- shapefile(file) #fa uno shp delle specie. 

species
species$Occurence #lo vedo da species

plot(species[species$Occurrence == 1,],col='blue',pch=16) #significa quando l'occurence è uguale a 1, quindi presente
points(species[species$Occurrence == 0,],col='red',pch=16) #aggiungo i punti quando la specie è assente

path <- system.file("external", package="sdm")

#ora faccio una  lista
lst <- list.files(path=path, pattern='asc$', full.names = T) #pattern tutti quelli che hanno estensione asc ovvero ascii, full names dice che considero il full names quando faccio il comando
lst

preds <- stack(lst) #mette assieme tutti i file ascii che ho selezionato prima

plot(preds) #si vedono i 4 parametri

cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=16) #così vedo dove è presente in relazione all'elevazione. 

plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=16) #come sopra ma in relazione alla Temperatura

plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$vegetation, col=cl)
points(species[species$Occurrence == 1,], pch=16) #se preferisce essere coperta da altra vegetazione o no

d <- sdmData(train=species, predictors=preds)
d #si vedono le info (per esempio che abbiamo solo 1 specie

m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=d, methods="glm") #modello con tante variabili assieme. la dipendente è sempre l'occurence, la x invece è insieme di fattori (elevazione, ecc,..)
#data li deve prendere da d, il metodo da applicare è glm. 


#prediction
p1 <- predict(m1, newdata=preds) #dati da m1, newdata son i predictors
plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)





