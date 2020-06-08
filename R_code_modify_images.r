#per modificare immagini

setwd("/Users/giacomotrotta/lab")

library(raster)

library(ncdf4)
snow <- raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc")

cl <- colorRampPalette(c('darkblue','blue','light blue'))(100)

plot(snow, col=cl)

ext <- c(0, 20, 35, 50) #definisco il vettore che farà zoom 
zoom(snow, ext=ext) #fa zoom di estensione pari al vettore creato prima

snowitaly <- crop(snow, ext) #crop taglia l'immagine, quindi qui ne faccio una nuova. Crop immagine snow di estensione ext

zoom(snow, ext=drawExtent()) #il comando viene eseguito sull'immagine, si apre l'immagine e io devo disegnare col mouse lo zoom da fare



