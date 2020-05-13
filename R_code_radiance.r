#Radiance

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







