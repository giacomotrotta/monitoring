#R code per vedere le variazione di NO2 in europa
library(raster)

setwd("/Users/giacomotrotta/lab/NO2/") #ho precedentemente messo tutti i file nella directory NO2 dentro la cartella lab

#esercizio, importare le immagini EN1-13

rlist <- list.files(pattern="EN") 
import <- lapply(rlist, raster) #applica una certa funzione a una lista di file (qui la funzione rasetr alla mia rlist)
EN <- stack(import)

cl <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(EN, col=cl)

#january and march

par(mfrow=c(1,2))
plot(EN$EN_0001, col=cl)  #il dollaro collega all'argomento
plot(EN$EN_0013, col=cl)

#facciamo esperimento con plotRGB

plotRGB(EN, r=1, g=7, b=13, stretch="lin") #i numeri si riferiscono alle immagini. 1 è EN_0001 e così via

#difference map

dif <- EN$EN_0013 - EN$EN_0001 #differenza tra l'immagine 13 (marzo) e la 1 (gennaio)
cld <- colorRampPalette(c('blue','white','red'))(100)  #si vedono le grandi differenze in rosso e le piccole differenze in blue
#in lombardia si vede la più grande differenza tra le due immagini. Non sono le imagini migliori per valutare però, entrano in gioco altre variabili
plot(dif, col=cld)

#quantitative estimate
#boxplot indica la media, la maggior parte degli elementi, intervallo di confidenza e gli outlaier
#provo per gradi

boxplot(EN) #le barre nere sono i punti outlaier

#li rimuovo
boxplot(EN, outline=F)

#metto in orrizontale
boxplot(EN, outline=F, horizontal=T)

#metto gli assi
boxplot(EN, outline=F, horizontal=T, axes=T) #si nota che il maximum value cala da EN1 a 13


###
plot(EN$EN_0001, EN$EN_0013) #pixel immagine 1 con pixel 13. il concetto è che se su 01 ho valore 255 per esempio e mi aspetto che cali allora in 13 avro 200(per esempio). Così si vede se cambia no2 o meno
#la maggiorparte dei valori alti dunque deve essere sotto la bisettrice 1e 3 quadrante (y=x). Se è sopra inveve NO2 non è calata
abline(0, 1, col="red") #aggiungo la bisettrice Y=bx + a , a=0 e b=1

#si vede che il trend è sotto la bisettrice e quindi c'è un trend di decrecsita tra en1 e en 13 nella concentrazione di no2

### provo a fare la stessa cosa per il lavoro su snow

setwd("/Users/giacomotrotta/lab/snow/") #ho precedentemente messo tutti i file nella directory NO2 dentro la cartella lab
rlist <- list.files(pattern="snow")
rlist

import <- lapply(rlist, raster)
snow.multitemp <- stack(import)

snow.multitemp #per vedere levariabili da usare sotto
plot(snow.multitemp$snow2010r, snow.multitemp$snow2020r)
abline(0, 1, col="red") #si vede che i valori massimi di solito sono sotto la curva quindi i valori sono più bassi nel 2020 rispetto a 2010

plot(snow.multitemp$snow2000r, snow.multitemp$snow2020r)
abline(0,1,col="red") #qui si vede meglio, tutti i valori sotto la linea bisettrice

















