### Multipanel in R, 2 exercise

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
