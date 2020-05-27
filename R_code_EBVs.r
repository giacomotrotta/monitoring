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

################# cladonia example

library(raster)
library(RStoolbox)

setwd("/Users/giacomotrotta/lab")
clad <- brick("cladonia_stellaris_calaita.JPG") #serve per brickare l'immagine

plotRGB(clad, 1, 2, 3, stretch="Lin") #si vede l'immagine a colorni "naturali"

window <- matrix(1, nrow=3, ncol=3) #l'1 assegna il valore 1 alla mnstra matrice. va bene nel nostro caso ma non sempre
window

pairs(clad)

cladpca <- rasterPCA(clad) #faccio pca di clad
cladpca

summary(cladpca$model) #98% of information are related to the 1 component

plotRGB(cladpca$map, 1, 2, 3, stretch="Lin") #si vedono molto bene i diversi oggetti della foto, la neve per esempio, il muschio è marrone, ecc..

sd_clad <- focal(cladpca$map$PC1, w=window, fun=sd)

PC1_agg <- aggregate(cladpca$map$PC1, fact=10) #aggrego i pixel
sd_clad_agg <- focal(PC1_agg, w=window, fun=sd)


par(mfrow=c(1,2)
cl <- colorRampPalette(c('yellow','violet','black'))(100)  
plot(sd_clad, col=cl)
plot(sd_clad_agg, col=cl)    
    
    
    
    



    
    

 




