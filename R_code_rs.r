# R code for remote sensing data analysis

#raster
install.packages("raster")
install.packages("RStoolbox")

setwd("/Users/giacomotrotta/lab")
library(raster)

#importo le immagini della cartella lab
p224r63_2011 <- brick("p224r63_2011_masked.grd") #path=p r=row per trovare l'immagine del satellite in modo univocp

plot(p224r63_2011) #ogni banda ha un significato, 1=blu, 2=verde, 3=rosso, 4=near infrarosso, 5= medium infrared, 6=termal infrared

#Bande
#B1 blue
#B2 green
#B3 red
#B4 near infrared

cl <- colorRampPalette(c('black','grey','light grey'))(100) # cambio il colore all'immagine
plot(p224r63_2011, col=cl) 

# multiframe of different plots
par(mfrow=c(2,2)) #per avere diversi layer assieme. Nelle parentesi 2 righe per due colonne
#uso 2,2 perchè alla fine userò 4 bande
#B1
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100)
plot(p224r63_2011$B1_sre, col=clb) #il dollaro collega l'immagine alla banda b1 del blu

#B2
clg <- colorRampPalette(c('dark green','green','light green'))(100)
plot(p224r63_2011$B2_sre, col=clg)

#se chiudo la finestra del grafico il comando par non funziona e devo richiamarlo

#B3
clr <- colorRampPalette(c('dark red','red','pink'))(100)
plot(p224r63_2011$B3_sre, col=clr)

#B4
cln <- colorRampPalette(c('red','orange','yellow'))(100)
plot(p224r63_2011$B4_sre, col=cln)


#se voglio tutte le immagini una sotto l'altra devo scrivere
par(mfrow=c(4,1))

#chiudo tutti i grafici
dev.off()

#RGB per vedere con occhio umano
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #stretch streccha i colori più che si può
#Lin va scritto in maiuscolo

#per rendere più visibile la vegetazione uso il near infrared(so che le foglie riflettono quella lunghezza bene

#siccome posso usare solo 3 bande elimino il blu

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

#questo fa diventare rosso tutto il near infrared

#ex nir on the top of the G component

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")

#e infine nel b component
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")














