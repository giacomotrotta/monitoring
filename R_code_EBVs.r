#Essential biodiversity variable

library(raster)
library(RStoolbox)

setwd("/Users/giacomotrotta/lab")

snt <- brick("snt_r10.tif") #importo l'immagine
plot(snt)

#solite 4 bande

plotRGB(snt, 3, 2, 1, stretch="lin")
plotRGB(snt, 4, 3, 2, stretch="lin") #metto NIR al posto di Red

pairs(snt)

#PCA analysis

sntpca <- rasterPCA(snt)
sntpca #vedo che le informazioni del modello sono in $model

summary(sntpca$model)

plot(sntpca$map)
plotRGB(sntpca$map, 1, 2, 3, stretch = "lin")

#ora facciamo come visto nella jamboard a lezione
window <- matrix(1, nrow = 5, ncol = 5)
window


sd_snt <- focal(sntpca$map$PC1, w=window, fun=sd) #focal arriva da raster package, devo usare il dollaro per collegare le parti tra loro
# w dice la finestra da usare (usiamo quella che abbiamo appena creato. Fun sta per function. 
#metto fun=standard deviation. ? per vedere le altre funzioni

cl <- colorRampPalette(c('dark blue','green','orange','red'))(100) 
plot(sd_snt, col=cl) 

par(mfrow=c(1,2))
plotRGB(snt, 4, 3, 2, stretch="lin")
plot(sd_snt, col=cl) 
#si vede le differenze. Dove l'immagine è più uniforme la deviazione standard è più bassa.
#nei passaggi tra un ecosistema e un altro la sd è più alta


