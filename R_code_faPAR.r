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


