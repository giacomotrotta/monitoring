#r_code_snow con i dati presi da VITO

setwd("/Users/giacomotrotta/lab")
#metto il file scaricato nella cartella lab in modo da importarlo

library(ncdf4)
library(raster)

snowmay <- raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc") #raster importa solo una immagine, birck importa tutti i layer dell'immagine (per esempio quando ho diverse bande)
#warning message dice che non è una mappa del mondo intero, ma solo una parte ma non è un problema
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 

#ex plot the snow cover con color ramp palette

plot(snowmay, col=cl) #done

#SLOW manner to import the set
#importare tutti i dati in una sola volta
#creo nuova cartella nella cartella lab e metto i file relativi alla neve presi da iol

#imposto la wd sulla cartella snow
setwd("/Users/giacomotrotta/lab/snow/")

snow2000 <- raster("snow2000r.tif")
snow2005 <- raster("snow2005r.tif")
snow2010 <- raster("snow2010r.tif")
snow2015 <- raster("snow2015r.tif")
snow2020 <- raster("snow2020r.tif") 

#con par mfrow paragono le immagini
par(mfrow=c(2,3))

plot(snow2000, col=cl)
plot(snow2005, col=cl)
plot(snow2010, col=cl)
plot(snow2015, col=cl)
plot(snow2020, col=cl)

#troppe linee per fare questa  cosa, c'è un modo più veloce
#FAST method

#si usa la funzione lapply

rlist <- list.files(pattern="snow") #fa la lista di tutti i file nella cartella snow con come nome qualcosa che tontenga "snow"
import <- lapply(rlist, raster) 
#stack mette tutt come una pila unica
snow.multitemp <- stack(import)

plot(snow.multitemp, col=cl) #molte meno linee

#vediamo come cambierà la neve in futuro
#si può fare avendo i dati passati dei vari pixel e cercare il expected value per il 2025 per esempio
#prediction function

source("prediction.r") #file con lo script per fare la predizione fatto dal prof
#in generale source prende il file e lo usa per fare il codice
#posso far partire qualsiasi codice così
plot(predicted.snow.2025.norm, col=cl)
##############

load("/Users/giacomotrotta/lab/snow/lecture.RData") #carico i dati della scorsa lezione

#exercise plot together all the graphs

listsnow <- list.files(pattern="snow") #ho rinominato la tiff di prediction afficnhè avesse snow nel nome, altrimenti non la trovava
importsnow <- lapply(listsnow, raster) 
snow.multitemp <- stack(importsnow)
plot(snow.multitemp, col=cl)

pdf("variation_snow_cover.pdf") #così faccio una stampa in pdf del risultato
plot(snow.multitemp, col=cl)
dev.off()

#sopra ho fatto io, sotto è come fa il prof

rlist <- list.files(pattern="snow") #faccio la lista dei nomi
rlist

import <- lapply(rlist, raster) 
snow.multitemp <- stack(import) #stack mette tutt come una pila unica
plot(snow.multitemp, col=cl)

prediction <- raster("predicted.2025.norm.tif")
plot(prediction, col=cl)

#come inviare i rislutati
writeRaster(prediction, "final.tif") #viene fuori la prediction in formato tif, il contrario di raster. Infatti questa esporta da R alla folder e non viceversa come la funzione raster

#final stack

final.stack <- stack(snow.multitemp, prediction) #metto assieme tutto quello che ho fatto
plot(final.stack, col=cl)

#esporto il grafico

pdf("my_final_graph.pdf") #così faccio una stampa in pdf del risultato
plot(final.stack, col=cl)
dev.off()

#ora in png
png("my_final_graph.png") #si possono aggiungere un sacco di altre specifiche, ad esempio larghezza, pixel, ecc...
plot(final.stack, col=cl)
dev.off()






