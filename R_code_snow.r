#r_code_snow con i dati presi da VITO

setwd("/Users/giacomotrotta/lab")
#metto il file scaricato nella cartella lab in modo da importarlo

library(ncdf4)
library(raster)

snowmay <- raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc")
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







