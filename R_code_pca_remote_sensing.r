#R_code_pca_remote_sensing

setwd("/Users/giacomotrotta/lab")

library(raster)
library(RStoolbox)
library(ggplot2)

p224r63_2011 <- brick("p224r63_2011_masked.grd") 

#le bande sono come le altre volte quindi b1 blu, b2 verde, b3 rosso, b4 infrarosso
#b5 swir, b6 thermal, b7 swir, b8 pancromatic. swir sono medium near infrared. misurano due cose diverse b5 e b7

plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin") 

#faccio plot con ggplot
ggRGB(p224r63_2011, 5, 4, 3)

#same for the image of 1988

p224r63_1988 <- brick("p224r63_1988_masked.grd")
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin") 
ggRGB(p224r63_1988, 5, 4, 3)

#par per vedere le differenze
par(mfrow=c(1,2))
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin")
plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin") 

names(p224r63_2011) trovo i nomi delle bande
# "B1_sre" "B2_sre" "B3_sre" "B4_sre" "B5_sre" "B6_bt"  "B7_sre"

dev.off()
plot(p224r63_2011$B1_sre, p224r63_2011$B3_sre)
#si vede quanto sono correlate fra di loro (molto correlate)
#siccome sono molto correlate posso usare una sola delle due bande (pc1)

# pca analysis

p224r63_2011_res <- aggregate(p224r63_2011, fact=10) #riduco i pixel perchè altrimenti troppi dati
#qui serve rstoolbox
p224r63_2011_pca <- rasterPCA(p224r63_2011_res) 
p224r63_2011_pca #per le info (3 parti, call, model e map)


plot(p224r63_2011_pca$map) #plotto la mappa, il dollaro linka map a pca
#cambio colori
cl <- colorRampPalette(c('dark grey','grey','light grey'))(100) # 
plot(p224r63_2011_pca$map, col=cl)

#si vede che pc1 ha quasi tutte le informazioni, gli altri non sono al livello di pc1

summary(p224r63_2011_pca$model) #per vedere il summary del model e basta
#pc1 99.83% of the whole variation

pairs(p224r63_2011) #correla tutte le bande a due a due


plotRGB(p224r63_2011_pca$map, r=1, g=2, b=3, scale=1000, stretch="Lin") #i numeri sono i numeri dei principal component (PC)
#non serve scrivere r=pc1, basta 1. I nomi li vedo in names scrivendo p224r63_2011_pca$map


#same for 1988

p224r63_1988_res <- aggregate(p224r63_1988, fact=10)

p224r63_1988_pca <- rasterPCA(p224r63_1988_res) 

plot(p224r63_1988_pca$map, col=cl)
summary(p224r63_1988_pca$model)  #anche qui si vede che pc1 ha 99.56% CORRELATION
pairs(p224r63_1988)

plotRGB(p224r63_1988_pca$map, r=1, g=2, b=3, scale=1000, stretch="Lin")

#ora faccio le differenze tra le due immagini 

difpca <- p224r63_2011_pca$map - p224r63_1988_pca$map #sottrae ogni pixel tra 2011 e 1988 per ogni component

plot(difpca)
cldif <- colorRampPalette(c('blue','black','yellow'))(100)
plot(difpca, col=cldif)
difpca
plot(difpca$PC1,col=cldif)

#non so come mai ma cambia il nome da PC1 a layer.1 quindi. per me funziona il comando
plot(difpca$layer.1,col=cldif)
#controllare questa parte finale







