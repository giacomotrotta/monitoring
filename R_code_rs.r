# R code for remote sensing data analysis

#raster
install.packages("raster")
install.packages("RStoolbox")

setwd("/Users/giacomotrotta/lab")
library(raster)

#importo le immagini della cartella lab
p224r63_2011 <- brick("p224r63_2011_masked.grd") #path=p r=row per trovare l'immagine del satellite in modo univocp

plot(p224r63_2011) #ogni banda ha un significato, 1=blu, 2=verde, 3=rosso, 4=near infrarosso, 5= middle infrared, 6=termal infrared 7=middle infrared

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

#comparazione tra 2011 e 1988

library(raster)
p224r63_1988 <- brick("p224r63_1988_masked.grd")

plot(p224r63_1988)

#exercise plot in rgb entrambe le immagini
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #devo ricordarmi che il rosso è la banda 3 ecc. per assegnare la banda giusta al colore giusto

plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")

#plot in false colour rgb 432 both images

par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") 

#accentuo il rumore delle immagini. 2 modi, streccharle di più o usare multi analisi

par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist") #histogram stretch, no more linear
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist") 

#in base alla salute della foglia avrò rapporti diversi se faccio
#DVI=NIR-RED

dvi2011 <- p224r63_2011$B4_sre - p224r63_2011$B3_sre #il dollaro collega due cose tra loro
cld <- colorRampPalette(c('darkviolet','light blue','lightpink4'))(100)
plot(dvi2011, col=cld)

#si vede che la dvi non è omogenea. al centro della foresta ci sono foglie con molta acqua probabilmente

#exercise dvi for 1988
dvi1988 <- p224r63_1988$B4_sre - p224r63_1988$B3_sre #il dollaro collega due cose tra loro
cld2 <- colorRampPalette(c('darkviolet','light blue','orange'))(100)
plot(dvi1988, col=cld2)
#new colour
dvi1988 <- p224r63_1988$B4_sre - p224r63_1988$B3_sre #il dollaro collega due cose tra loro
cld2 <- colorRampPalette(c('darkblue','blue','light blue'))(100)
plot(dvi1988, col=cld2)

#difference from on year to the other
diff <- dvi2011 - dvi1988
plot(diff) #si vede dove è cambiata di più la dvi

#changing the grain

#aggregate() is the function. In pratica riduco la qualità dei pixel
p224r63_2011res <- aggregate(p224r63_2011, fact=10) #fattore 10
#res significa resempling
p224r63_2011res100 <- aggregate(p224r63_2011, fact=100)
#plot together
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") 
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="Lin") 
plotRGB(p224r63_2011res100, r=4, g=3, b=2, stretch="Lin") 
#si vede come a seconda della qualità posso o meno fare considerazioni
#nel res100 non si vede nulla delle coltivazioni agricole
p224r63_2011 #per avere info sull'immagine
#nell'ultima immagine ho una risoluzione di 3kmx3km, troppo poco














