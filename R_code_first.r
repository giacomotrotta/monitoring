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
