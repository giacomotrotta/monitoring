#R_code_exam.r

#1.  R code first
#2.  Multipanel in R, 2 exercise
#3.  R code for spatial view of point
#4.  R code for multivariate analysis
#5.  R code pca remote sensing
#6. 
#7.  R code for remote sensing data analysis
#8.  R code to view biomass over the world and calculate changese in ecosystem functions
#9.  R code ecosystem reflectance
#10. faPAR
#11. Essential biodiversity variable
#12. R code snow cover
#13. R code NO2
#14. R code interpolation with our data
#15.

#######################################################################

#1. R code first

install.packages("sp")

library(sp)
data(meuse)

#se uso hasthag r non legge
#sotto mi favedere il dataset
meuse

#funzione per vedere le prime 6 righe del dataset
head(meuse)

#vediamo se la concentrazione di zinco è collegata al rame
attach(meuse)
#per vedere la funzion plot posso guardare questo link https://www.rdocumentation.org/packages/graphics/versions/3.6.2/topics/plot
plot(zinc,copper)
#col=something cambia colore
plot(zinc,copper,col="green")
#per cambiare i simboli dei dati uso pch e poi un numero. ogni numero corrisponde a un simbolo. per vederei simboli posso cercare su internet pch r symbol
plot(zinc,copper,col="green",pch=19)
#aumentare size pallini 
plot(zinc,copper,col="green",pch=19,cex=2)


####################################################################
####################################################################
####################################################################

#2. Multipanel in R, 2 exercise

install.packages("sp")
install.packages("GGally") #R riconosce maiuscole e minuscole quindi devo scriverlo esattamente così

library(sp) #require(sp) può essere usato come sostituto della funzione
library(GGally)

data(meuse) #this means there is a dataset available, now i want to use it

attach(meuse)

#exercise in lab --> plot zinc and cadmium

head(meuse) #to see the name of the colomn or names(meuse)

plot(zinc,cadmium,col="black",pch=19,cex=2) #done

#exercise: make all the possible paiwis plots with the dataset. 
#potrei farlo manualmente ma non ha senso fare plot per ognuno

pairs(meuse)

#ora lo rendo più leggibile riducendo le variabili, per fare tilde ~ devo fare option+5
pairs(~ cadmium + copper + lead + zinc, data=meuse)

#another method per fare un subset. utilizzo le posizioni delle colonne nel dataset (esempio cadmium è la terza) 
#comma means "start from" and : means "untill"
pairs(meuse[,3:6])

#exercise: prettify the graphs sopra
pairs(meuse[,3:6],col="blue", pch=3, cex=1.5) #done

#GGally function will prettify the graphs
ggpairs(meuse[,3:6])

####################################################################
####################################################################
####################################################################


#3.  R code for spatial view of point

library(sp)

data(meuse)
head(meuse)

#coordinates
coordinates(meuse) = ~x+y   

plot(meuse)
spplot(meuse, "zinc")

#exercise:plot the spacial amount of copper
spplot(meuse, "copper") #done
spplot(meuse, "copper", main="Copper concentration")  #la funzione main da il titolo al grafico

bubble(meuse, "zinc", main="Zinc concentration") #same information but we don't use colours but size of bubble (bigger they are higher concentration as results)

#exercise: bubble copper in red
bubble(meuse, "copper", main="Copper concentration", col="red") #done

###importing new data from iol:exercise on covid. we also build a folder lab in my user folder
#put the file in the folder lab

#setting the working directory:lab. Do it based on your operative system
#mac user
setwd("/Users/giacomotrotta/lab")

#collego una funzione ad un oggeto così non devo ripetere ogni volta che deve leggere quella tabella. Dopo la virgola gli dico che la prima riga non sono dati ma è l'head, le descrizioni delle colonne
covid <- read.table("covid_agg.csv", head=TRUE) #TRUE o T sono come scrivere la stessa cosa

attach(covid)
plot(country,cases) #il primo è la x, il secondo asse y

plot(country, cases, las=0) #parallel labels
plot(country, cases, las=1) #horizontal labels
plot(country, cases, las=2) #perpendicular labels tutti questi si intende rispetto agli assi
plot(country, cases, las=3) #vertical labels

plot(country, cases, las=3, cex.axis=0.5) #exagerate the dimension of the axis

#ggplot 2 package per un grafico bello

install.packages("ggplot2")

library(ggplot2)

#load the previous session
load("/Users/giacomotrotta/lab/R_code_spatial.RData")

ls() #list, to check if i'm working with the correct data (in this case I will see "Covid")

library(ggplot2)
#in ggplot2 c'è un dataframe chiamoato mpg cpn dei dati su vetture
data(mpg)

head(mpg) #vedo le colonne e i relativi titoli per scegliere cosa plottare
#3 key components: data, aes, geometry. geometry è una parte separata, va aggiunta col +
ggplot(mpg, aes(x=displ,y=hwy)) + geom_point()
#let's change the geometry of this graphs 
ggplot(mpg, aes(x=displ,y=hwy)) + geom_line() #putting lines within the dots
ggplot(mpg, aes(x=displ,y=hwy)) + geom_polygon() #fa poligoni tra i punti

#now we can try with covid data
head(covid)
ggplot(covid, aes(x=lon, y=lat, size=cases)) + geom_point()#size esagera la diemnsione dei punti in base ai casi

#nel mio mac da errore -> Error in UseMethod("depth") : no applicable method for 'depth' applied to an object of class "NULL"
#per risolverlo aggiro il problema
#assegno un oggetto al plot
graphs <- ggplot(covid, aes(x=lon, y=lat, size=cases)) + geom_point()
#poi plotto l'oggetto
plot(graphs)  
#in ogni caso internet dice che per i mac è un errore comune. Basta chiudere R e riaprirlo e funziona

####################################################################
####################################################################
####################################################################


#4. R code for multivariate analysis

setwd("/Users/giacomotrotta/lab") #controllare sempre di mettere lo slash prima di users
install.packages("vegan")
library(vegan)

biomes <- read.table("biomes.csv", head=T, sep=",") #sep indica che le colonne sono separate da una virgola
head(biomes) #per vedere i dati come son fatti

#Detrended CORrespondence ANAlysis

multivar <- decorana(biomes)

plot(multivar)

multivar #da info sulla variabile. Eigenvalues da valori che indicano la percentuale
#dal grafico si vede che le specie legate tra loro nei biomi sono anche vicine graficamente
#vicinanza indica relazione tra specie

biomes_types <- read.table("biomes_types.csv", head=T, sep=",") #come sopra per leggere i dati
head(biomes_types)

attach(biomes_types)

#uso la funzione ordiellipse
ordiellipse(multivar, type, col=1:4, kind = "ehull", lwd=3) #fa una funzione che collega tutti i dati appartenenti a un certo bioma con ellisse

#type indica il titolo della colonna da usare.
#col dice i colori da usare in questo caso 4 colori
#kind dice il tupo di grafico che uso, ehull indica elisse hull
#lwd quanto grande voglio la linea

ordispider(multivar, type, col=1:4, label = T) #label da il titolo del bioma al colore, spider collega il centro dell'ellisse coi punti dell'ellisse

####################################################################
####################################################################
####################################################################


#5. R_code_pca_remote_sensing

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

#non so come mai ma cambia il nome da PC1 a layer.1 quindi per me funziona il comando
plot(difpca$layer.1,col=cldif)
#controllare questa parte finale
#difpca <- p224r63_2011_pca$map - p224r63_1988_pca$map
#plot(difpca)
#plot(difpca$PC1,col=cldif) 

####################################################################
####################################################################
####################################################################

#6.


####################################################################
####################################################################
####################################################################


#7. R code for remote sensing data analysis

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

####################################################################
####################################################################
####################################################################

#8. R code to view biomass over the world and calculate changese in ecosystem functions
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

####################################################################
####################################################################
####################################################################

#9. Radiance

library(raster)

#inventiamo un po' di dati
toy <- raster(ncol=2, nrow=2, xmn=1, xmx=2, ymn=1, ymx=2) #raster 2x2
values(toy) <- c(1.13, 1.44, 1.55, 3.4)

plot(toy)
text(toy, digits=2) #aggiunge i valori nel plot(me li fa vedere)

#cambio i dati nei valori potenziali
toy2bits <- stretch(toy, minv=0, maxv=3) #aumento a 4 valori potenziali. 2^2 da 4 valori. valore minimo 0 valore massimo 3
storage.mode(toy2bits[]) = "integer"
plot(toy2bits)
text(toy2bits, digits=2)

#provo 16 valori potenziali (da 0 a 15)
toy4bits <- stretch(toy, minv=0, maxv=15) 
storage.mode(toy4bits[]) = "integer"
plot(toy4bits)
text(toy4bits, digits=2)
#nel raster si vedono i numeri stretchati. 

#provo con 2^8 quindi 256 valori
toy8bits <- stretch(toy, minv=0, maxv=255) 
storage.mode(toy8bits[]) = "integer"
plot(toy8bits)
text(toy8bits, digits=2)

#metto assieme i raster ottenuti
par(mfrow=c(1,4))
plot(toy)
text(toy, digits=2)
plot(toy2bits)
text(toy2bits, digits=2)
plot(toy4bits)
text(toy4bits, digits=2)
plot(toy8bits)
text(toy8bits, digits=2)
#più valori alti ho più ho differenza tra i pixel

dev.off()
library(rasterdiv)
plot(copNDVI)
copNDVI #vedo il range dei dati e scopro che usano 8bits

####################################################################
####################################################################
####################################################################

#10. faPAR
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


####################################################################
####################################################################
####################################################################

#11. Essential biodiversity variable

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


par(mfrow=c(1,2))
cl <- colorRampPalette(c('yellow','violet','black'))(100)  
plot(sd_clad, col=cl)
plot(sd_clad_agg, col=cl) #confronto le differenze tra quello aggregato e quello no

plotRGB(clad, 1,2,3, stretch="lin")
plot(sd_clad, col=cl) #vedo le differenze delle immagini vicine

plotRGB(clad, 1,2,3, stretch="lin")
plot(sd_clad_agg, col=cl)
    
####################################################################
####################################################################
####################################################################

#12. R code snow cover
#r_code_snow con i dati presi da VITO

setwd("/Users/giacomotrotta/lab")
#metto il file scaricato nella cartella lab in modo da importarlo

library(ncdf4)
library(raster)

snowmay <- raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc") #raster importa solo una immagine, birck importa tutti i layer dell'immagine (per esempio quando ho diverse bande)
#warning message dice che non è una mappa del mondo intero, ma solo una parte ma non è un problema
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 

#ex plot the snow cover con color ramp palette

plot(snowmay, col=cl) #done

#SLOW manner to import the set
#importare tutti i dati in una sola volta
#creo nuova cartella nella cartella lab e metto i file relativi alla neve presi da iol

#imposto la wd sulla cartella snow
setwd("/Users/giacomotrotta/lab/snow/")

snow2000 <- raster("snow2000r.tif")
snow2005 <- raster("snow2005r.tif")
snow2010 <- raster("snow2010r.tif")
snow2015 <- raster("snow2015r.tif")
snow2020 <- raster("snow2020r.tif") 

#con par mfrow paragono le immagini
par(mfrow=c(2,3))

plot(snow2000, col=cl)
plot(snow2005, col=cl)
plot(snow2010, col=cl)
plot(snow2015, col=cl)
plot(snow2020, col=cl)

#troppe linee per fare questa  cosa, c'è un modo più veloce
#FAST method

#si usa la funzione lapply

rlist <- list.files(pattern="snow") #fa la lista di tutti i file nella cartella snow con come nome qualcosa che tontenga "snow"
import <- lapply(rlist, raster) #applica una certa funzione a una lista di file (qui la funzione rasetr alla mia rlist)
#stack mette tutt come una pila unica
snow.multitemp <- stack(import)

plot(snow.multitemp, col=cl) #molte meno linee

#vediamo come cambierà la neve in futuro
#si può fare avendo i dati passati dei vari pixel e cercare il expected value per il 2025 per esempio
#prediction function

source("prediction.r") #file con lo script per fare la predizione fatto dal prof
#in generale source prende il file e lo usa per fare il codice
#posso far partire qualsiasi codice così
plot(predicted.snow.2025.norm, col=cl)
##############

load("/Users/giacomotrotta/lab/snow/lecture.RData") #carico i dati della scorsa lezione

#exercise plot together all the graphs

listsnow <- list.files(pattern="snow") #ho rinominato la tiff di prediction afficnhè avesse snow nel nome, altrimenti non la trovava
importsnow <- lapply(listsnow, raster) 
snow.multitemp <- stack(importsnow)
plot(snow.multitemp, col=cl)

pdf("variation_snow_cover.pdf") #così faccio una stampa in pdf del risultato
plot(snow.multitemp, col=cl)
dev.off()

#sopra ho fatto io, sotto è come fa il prof

rlist <- list.files(pattern="snow") #faccio la lista dei nomi
rlist

import <- lapply(rlist, raster) 
snow.multitemp <- stack(import) #stack mette tutt come una pila unica
plot(snow.multitemp, col=cl)

prediction <- raster("predicted.2025.norm.tif")
plot(prediction, col=cl)

#come inviare i rislutati
writeRaster(prediction, "final.tif") #viene fuori la prediction in formato tif, il contrario di raster. Infatti questa esporta da R alla folder e non viceversa come la funzione raster

#final stack

final.stack <- stack(snow.multitemp, prediction) #metto assieme tutto quello che ho fatto
plot(final.stack, col=cl)

#esporto il grafico

pdf("my_final_graph.pdf") #così faccio una stampa in pdf del risultato
plot(final.stack, col=cl)
dev.off()

#ora in png
png("my_final_graph.png") #si possono aggiungere un sacco di altre specifiche, ad esempio larghezza, pixel, ecc...
plot(final.stack, col=cl)
dev.off()

####################################################################
####################################################################
####################################################################

#13. #R code per vedere le variazione di NO2 in europa
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


####################################################################
####################################################################
####################################################################

#14. R code interpolation with our data

setwd("/Users/giacomotrotta/lab/")

#step per interpolazione
#1 explain to spatstat that we have coordinates (con ppp gli dico che ho i punti in sistema di coordinate)
#2 spiegare a spatstat che abbiamo dati ecologici 
#3 fare la spatial map

library(spatstat)

inp <- read.table("dati_plot55_LAST3.csv", sep=";", head=T) #separatore delle colonne è ; mentre la prima riga è di titoli delle colonne quindi head=TRUE

head(inp)
attach(inp) #per usare il dataset, altrimenti dovrei richiamare ogni volta il dataset col dollaro

plot(X, Y)


summary(inp) #mi fa vedere minimo e massimo

inppp <- ppp(x=X, y=Y, c(716000, 718000), c(4859000, 4861000))  #spieghiamo cosa sono x e y nel nostro dataset e il range di x e y (minimo e massimo). così spatstat può capire il range del dataset. 
names(inp) #per trovare il nome della canopy cover
marks(inppp) <- Canopy.cov

canopy <- Smooth(inppp)
plot(canopy)
points(inppp, col="Green")

marks(inppp) <- cop.lich.mean #voglio vedere quanto coprono i licheni
lichs <- Smooth(inppp)
plot(lichs)
points(inppp)

#output <- stack(canopy, lichs)
#plot(lichs)

par(mfrow=c(1,3))
plot(canopy)
points(inppp)
plot(lichs)
points(inppp)

plot(Canopy.cov, cop.lich.mean, col="red", pch=19, cex=2)

#######

inp.psam <- read.table("dati_psammofile.csv", sep=";", head=T)
attach(inp.psam)

head(inp.psam)
plot(E, N)
summary(inp.psam) #per vedere range
inp.psam.ppp <- ppp(x=E, y=N, c(356450,372240),c(5059800,5064150))

marks(inp.psam.ppp) <- C_org

C <- Smooth(inp.psam.ppp) #da errore perchè ho pochi valori per alcune zone (perchè ho clumped data quindi spatstat fa difficoltà a stimare i dati dove non ci sono
plot(C)
points(inp.psam.ppp)

####################################################################
####################################################################
####################################################################

####################################################################
####################################################################
####################################################################























