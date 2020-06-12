#R_code_exam.r

#1. R code first
#2.  R code for spatial view of point

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

#2.  R code for spatial view of point

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






