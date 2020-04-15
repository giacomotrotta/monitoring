#R code for multivariate analysis

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
#kind dice il tupo di grafico che uso ehull indica elisse hull
#lwd quanto grande voglio la linea

ordispider(multivar, type, col=1:4, label = T) #label da il titolo del bioma al colore, spider collega il centro dell'ellisse coi punti dell'ellisse







