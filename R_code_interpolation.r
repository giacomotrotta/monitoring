#R code interpolation with our data

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








