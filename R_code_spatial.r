#R code for spatial view of point

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






