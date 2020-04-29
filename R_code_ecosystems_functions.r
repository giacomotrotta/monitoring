#R code to view biomass over the world and calculate changese in ecosystem functions
#energy
#chemical cycling
#proxies

install.packages("rasterdiv")
install.packages("rasterVis")

library(rasterVis)
library(rasterdiv)

data(copNDVI) #diciamo quali dati useremo
plot(copNDVI)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA)) #riclassifico i dati originali. Perchè sono quelli dell'acqua

#levelplot 

levelplot(copNDVI) #vedo la biomassa degli ultimi 20 anni

#aggrego i pixel di fattore 10 per rendere più liscio il grafico

copNDVI10 <- aggregate(copNDVI, fact=10) #pixel dimension of a factor of ten
levelplot(copNDVI10)

copNDVI100 <- aggregate(copNDVI, fact=100) #pixel dimension of a factor of 100
levelplot(copNDVI100)

#code for the future!
#library(ggplot2)

#myPalette <- colorRampPalette(c('white','green','dark green'))
#sc <- scale_colour_gradientn(colours = myPalette(100), limits=c(1, 8))

#ggR(copNDVI, geom_raster = TRUE) +
#scale_fill_gradientn(name = "NDVI", colours = myPalette(100))+
#labs(x="Longitude",y="Latitude", fill="")+
#   theme(legend.position = "bottom") + NULL
# +
# ggtitle("NDVI")

####################################################

#how much of the primary forest are we converting in agricultural land

setwd("/Users/giacomotrotta/lab")

library(raster)

defor1 <- brick("defor1_.jpg")
defor2 <- brick("defor2_.jpg")

#band1: NIR, defor1_.1
#B2: red, defor1_.2 sono i nomi delle bande. li vedo scrivendo defor1 su r
#B3: green

plotRGB(defor1, r=1, g=2, b=3, stretch="Lin") #NIR lo vedrò rosso, quindi la vegetazione la vedrò rossa
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")
 
par(mfrow=c(1,2)) #per vederle vicine
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin") 
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

#reminder. La vegetazione riflette bene NIR perchè non li usa per fotosintesi. 

dvi1 <- defor1$defor1_.1 - defor1$defor1_.2 #per vedere quanto sono sane le vegetazioni
dvi2 <- defor2$defor2_.1 - defor2$defor2_.2 

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
par(mfrow=c(1,2)) 
plot(dvi1, col=cl)
plot(dvi2, col=cl)

difdvi <- dvi1 - dvi2 #pixel per pixel fa la differenza
dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld) #vedo le differenze. Tutte le parti in cui c'era foresta e ora campi è in rosso 

hist(difdvi) #mostra istogramma con differenze. Fa vedere che ci sono diversi valori maggiori di 0. Significa grande perdita di foresta


 











