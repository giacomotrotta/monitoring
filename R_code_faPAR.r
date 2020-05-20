#How to look at chemical cycling from satellites

library(raster)
library(rasterVis)
library(rasterdiv)

#NDVI=NIR-RED

plot(copNDVI) #è già nella library raster
copNDVI <- reclassify(copNDVI, cbind(253:255, NA)) #253,255 sono acqua, quindi la elimino
levelplot(copNDVI)

setwd("/Users/giacomotrotta/lab/")
faPAR10 <- raster("/Users/giacomotrotta/lab/faPAR10.tif") #per importare i dati
levelplot(faPAR10) 
#si vede che nell'emisfero nord il fapar non è alto quanto ndvi visto prima.
#perchè consideriamo la forza delle piante di prendere la luce, non della biomassa
#esempio della foresta di faggio e conifere. Nel faggio molta luce va a terra e non viene usata
#nelle conifere anche ci sono degli spazi vuoti che non vengono usati.
#le foreste tropicali usano tutta la luve che hanno a disposizione invece. 
#ecco perchè l'uptake di C è maggiore nelle foreste tropicali(si vede nelle immagini di R)

#salvo in pdf
pdf("copNDVI.pdf")
levelplot(copNDVI)
dev.off()

pdf("faPAR.pdf")
levelplot(faPAR10)
dev.off()

##########continuazione

#tenere a mente che da copernivìcus i file che ottengo pesano 2gb a immagine. 
#quella che stiamo usando pesa molto meno. é già stata elaborata

library(raster)
library(rasterdiv)
library(rasterVis)

writeRaster(copNDVI, "copNDVI.tif") #5.5 MB invece che 2 GB

#exercise faPAR levelplot
levelplot(faPAR10) #fapar fraction of photosyntesis. 
#La radiazione che arriva dal sole e che è usata esplicitamente per la fotosintesi

##### Regression model between faPAR and NDVI
#esempio di creazione di serie di numeri

erosion <- c(12, 14, 16, 24, 26, 40, 55, 67)
hm <- c(30, 100, 150, 200, 260, 340, 460, 600)

plot(erosion, hm, col="red", pch=19, xlab="erosion", ylab="heavy metals (nichel, ppm)", cex=2)
#sembra ci sia una relazione, più erode più metalli ho. Faccio un linear model

model1 <- lm(hm ~ erosion) # ~ significa equal in questa funzione. 
summary(model1) #informazioni sulla retta che indica la regressione. Ho m e intercetta  della retta
#r squared va da 0 a 1. più e vicino a 1 più il nostro modello è vicino ai dati che abbiamo
#pvalue più è piccolo più è statisticamente significativo
abline(model1) #aggiunge  al grafico

library(raster)
setwd("/Users/giacomotrotta/lab")
faPAR10 <- raster("faPAR10.tif")

plot(copNDVI)
plot(faPAR10)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA), right=TRUE)
    

library(sf) # to call st_* functions
random.points <- function(x,n)
{
lin <- rasterToContour(is.na(x))
pol <- as(st_union(st_polygonize(st_as_sf(lin))), 'Spatial') # st_union to dissolve geometries
pts <- spsample(pol[1,], n, type = 'random')
}

pts <- random.points(faPAR10,1000) 

copNDVIp <- extract(copNDVI, pts)
faPAR10p <- extract(faPAR10, pts)

model2 <- lm(faPAR10p ~ copNDVIp) #(cop è la y, fapar è x)
summary(model2) #qua r quadro è più basso di prima, non tutti i punti saranno sulla linea

plot(copNDVIp, faPAR10p, col="green", xlab="biomass", ylab="photosynthesis")
abline(model2, col="red")









