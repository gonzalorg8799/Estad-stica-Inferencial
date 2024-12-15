unionesDeHecho=read.csv2("uniones_de_hecho.csv")

uniones.primera.franja=unionesDeHecho[((unionesDeHecho$Año==2010)|(unionesDeHecho$Año==2011)|(unionesDeHecho$Año==2012)|(unionesDeHecho$Año==2013)|(unionesDeHecho$Año==2014)|(unionesDeHecho$Año==2015)|(unionesDeHecho$Año==2016)),]
uniones.segunda.franja=unionesDeHecho[((unionesDeHecho$Año==2017)|(unionesDeHecho$Año==2018)|(unionesDeHecho$Año==2019)|(unionesDeHecho$Año==2020)|(unionesDeHecho$Año==2021)|(unionesDeHecho$Año==2022)|(unionesDeHecho$Año==2023)),]

uniones.primera.franja$franja = rep(c("primera"), times = nrow(uniones.primera.franja))
uniones.segunda.franja$franja = rep(c("segunda"), times = nrow(uniones.segunda.franja))

uniones.con.franja = rbind(uniones.primera.franja, uniones.segunda.franja)

solicitudes<- as.numeric(uniones.con.franja$Solicitudes.presentadas)
franja=uniones.con.franja$franja

solicitudes.primera <- as.numeric(uniones.primera.franja$Solicitudes.presentadas)
solicitudes.segunda <- as.numeric(uniones.segunda.franja$Solicitudes.presentadas)

mean(solicitudes.primera.muestra.grande)
mean(solicitudes.segunda.muestra.grande)

median(solicitudes.primera.muestra.grande)
median(solicitudes.segunda)
##Longitud de las solicitudes de cada franja
length(uniones.primera.franja)
length(uniones.segunda.franja)
tapply(solicitudes, franja, length)
length(solicitudes)

##Creacion de variables que contengan las muestras grandes
(solicitudes.primera.muestra.grande=solicitudes.primera)
(solicitudes.segunda.muestra.grande=solicitudes.segunda)

##Comprobar normalidad
install.packages("car")
library(car)
par(mfrow=c(1,2))
qqPlot(solicitudes.primera.muestra.grande, main = "Primera_franja")
qqPlot(solicitudes.segunda.muestra.grande, main = "Segunda_franja")

#test Jarque-Bera
install.packages("tseries")
library(tseries)
jarque.bera.test(solicitudes.primera.muestra.grande)
jarque.bera.test(solicitudes.segunda.muestra.grande)


#Muestras de tamaño pequeño
(solicitudes.primera.muestra.pequeña=sample(solicitudes.primera,20))
(solicitudes.segunda.muestra.pequeña=sample(solicitudes.segunda,20))
shapiro.test(solicitudes.primera.muestra.pequeña)
shapiro.test(solicitudes.segunda.muestra.pequeña)

#comprobacion grafica
par(mfrow=c(1,2))
L=c(34,80,200,300,581)
hist(solicitudes.primera.muestra.pequeña, breaks = L, main="Primera franja (muestra pequeña)",
       ylim=c(0,0.05), ylab = "", xlab = "Solicitudes", freq = FALSE)
curve(dnorm(x,mean(solicitudes.primera.muestra.pequeña),sd(solicitudes.primera.muestra.pequeña)),0,600,
        add=TRUE, col="red")
hist(solicitudes.segunda.muestra.pequeña, breaks = L, main="Segunda franja (muestra pequeña)",
       ylim=c(0,0.4), ylab = "", xlab = "Solicitudes", freq = FALSE)
curve(dnorm(x,mean(solicitudes.segunda.muestra.pequeña),sd(solicitudes.segunda.muestra.pequeña)),0,12,
        add=TRUE, col="red")
#------------------------------------#
#Transformación de los datos
solicitudes.primera.muestra.grande.transformadas=log10(solicitudes.primera.muestra.grande)
solicitudes.segunda.muestra.grande.transformadas=log10(solicitudes.segunda.muestra.grande)
solicitudes.primera.muestra.pequeña.transformadas=log10(solicitudes.primera.muestra.pequeña)
solicitudes.segunda.muestra.pequeña.transformadas=log10(solicitudes.segunda.muestra.pequeña)

#comprobacion de los datos transformados
jarque.bera.test(solicitudes.primera.muestra.grande.transformadas)
jarque.bera.test(solicitudes.segunda.muestra.grande.transformadas)
par(mfrow=c(1,2))
qqPlot(solicitudes.primera.muestra.grande.transformadas, main = "Primera franja (muestra grande)")
qqPlot(solicitudes.segunda.muestra.grande.transformadas, main = "Segunda franja (muestra grande)")
par(mfrow=c(1,2))
qqPlot(solicitudes.primera.muestra.pequeña.transformadas, main= "Primera franja (muestra pequeña)")
qqPlot(solicitudes.segunda.muestra.pequeña.transformadas, main="Segunda franja (muestra pequeña")
##histogramas
# Definir los límites de los histogramas basados en los datos transformados
L1 <- seq(min(solicitudes.primera.muestra.grande.transformadas), max(solicitudes.primera.muestra.grande.transformadas), length.out = 10)
L2 <- seq(min(solicitudes.segunda.muestra.grande.transformadas), max(solicitudes.segunda.muestra.grande.transformadas), length.out = 10)

# Histograma para Primera y segunda franja de las muestras grandes
par(mfrow=c(1,2))
hist(solicitudes.primera.muestra.grande.transformadas, breaks = L1, main = "Primera franja (muestra grande transformada)",
     ylim = c(0, 1), ylab = "", xlab = "Solicitudes", freq = FALSE)
curve(dnorm(x, mean(solicitudes.primera.muestra.grande.transformadas), sd(solicitudes.primera.muestra.grande.transformadas)), 
      from = min(solicitudes.primera.muestra.grande.transformadas), 
      to = max(solicitudes.primera.muestra.grande.transformadas), 
      add = TRUE, col = "red")

hist(solicitudes.segunda.muestra.grande.transformadas, breaks = L2, main = "Segunda franja (muestra grande transformada)",
     ylim = c(0, 1), ylab = "", xlab = "Solicitudes", freq = FALSE)
curve(dnorm(x, mean(solicitudes.segunda.muestra.grande.transformadas), sd(solicitudes.segunda.muestra.grande.transformadas)), 
      from = min(solicitudes.segunda.muestra.grande.transformadas), 
      to = max(solicitudes.segunda.muestra.grande.transformadas), 
      add = TRUE, col = "red")


L1 <- seq(min(solicitudes.primera.muestra.pequeña.transformadas), max(solicitudes.primera.muestra.pequeña.transformadas), length.out = 10)
L2 <- seq(min(solicitudes.segunda.muestra.pequeña.transformadas), max(solicitudes.segunda.muestra.pequeña.transformadas), length.out = 10)
# Histograma para la segunda franja (muestra pequeña)
par(mfrow=c(1,2))
hist(solicitudes.primera.muestra.pequeña.transformadas, breaks = L1, main = "Primera franja (muestra pequeña)",
     ylim = c(0, 1), ylab = "", xlab = "Solicitudes", freq = FALSE)
curve(dnorm(x, mean(solicitudes.primera.muestra.pequeña.transformadas), sd(solicitudes.primera.muestra.pequeña.transformadas)), 
      from = min(solicitudes.primera.muestra.pequeña.transformadas), 
      to = max(solicitudes.primera.muestra.pequeña.transformadas), 
      add = TRUE, col = "red")

hist(solicitudes.segunda.muestra.pequeña.transformadas, breaks = L2, main = "Segunda franja (muestra pequeña)",
     ylim = c(0, 1), ylab = "", xlab = "Solicitudes", freq = FALSE)
curve(dnorm(x, mean(solicitudes.segunda.muestra.pequeña.transformadas), sd(solicitudes.segunda.muestra.pequeña.transformadas)), 
      from = min(solicitudes.segunda.muestra.pequeña.transformadas), 
      to = max(solicitudes.segunda.muestra.pequeña.transformadas), 
      add = TRUE, col = "red")

##Saphiro-wilk
shapiro.test(solicitudes.primera.muestra.grande.transformadas)
shapiro.test(solicitudes.segunda.muestra.grande.transformadas)
shapiro.test(solicitudes.primera.muestra.pequeña.transformadas)
shapiro.test(solicitudes.segunda.muestra.pequeña.transformadas)

##Jarque-bera
jarque.bera.test(solicitudes.primera.muestra.grande.transformadas)
jarque.bera.test(solicitudes.segunda.muestra.grande.transformadas)
#Intervalos de confianza para la media
install.packages("BSDA")
library(BSDA)
z.test(solicitudes.primera.muestra.grande.transformadas, sigma.x = sd(solicitudes.primera.muestra.grande.transformadas), conf.level = 0.95)
z.test(solicitudes.segunda.muestra.grande.transformadas, sigma.x = sd(solicitudes.segunda.muestra.grande.transformadas), conf.level = 0.95)

#Intervalos de confianza para datos pequeños
t.test(solicitudes.primera.muestra.pequeña.transformadas, conf.level = 0.95)
t.test(solicitudes.segunda.muestra.pequeña.transformadas,conf.level = 0.95)



#diagramas
# Desactivar notación científica
options(scipen=999)

# Intervalos de confianza para muestras grandes
# Primera franja
test.primera.grande <- t.test(solicitudes.primera.muestra.grande.transformadas, conf.level = 0.95)
Li.primera.grande <- 10^test.primera.grande$conf.int[1]
Ls.primera.grande <- 10^test.primera.grande$conf.int[2]

# Segunda franja
test.segunda.grande <- t.test(solicitudes.segunda.muestra.grande.transformadas, conf.level = 0.95)
Li.segunda.grande <- 10^test.segunda.grande$conf.int[1]
Ls.segunda.grande <- 10^test.segunda.grande$conf.int[2]

# Intervalos de confianza para muestras pequeñas
# Primera franja
test.primera.pequeña <- t.test(solicitudes.primera.muestra.pequeña.transformadas, conf.level = 0.95)
Li.primera.pequeña <- 10^test.primera.pequeña$conf.int[1]
Ls.primera.pequeña <- 10^test.primera.pequeña$conf.int[2]

# Segunda franja
test.segunda.pequeña <- t.test(solicitudes.segunda.muestra.pequeña.transformadas, conf.level = 0.95)
Li.segunda.pequeña <- 10^test.segunda.pequeña$conf.int[1]
Ls.segunda.pequeña <- 10^test.segunda.pequeña$conf.int[2]

# Graficar los intervalos de confianza
# Definir puntos y límites para el gráfico
x <- c(1, 1, 1.1, 1.1, 2, 2, 2.1, 2.1)
y <- c(Li.primera.grande, Ls.primera.grande, 
       Li.segunda.grande, Ls.segunda.grande, 
       Li.primera.pequeña, Ls.primera.pequeña, 
       Li.segunda.pequeña, Ls.segunda.pequeña)

# Crear el gráfico
plot(x, y, xlim = c(0.5, 2.5), ylim = c(min(y) - 0.5, max(y) + 0.5), 
     xlab = "1 = Muestras grandes, 2 = Muestras pequeñas", 
     ylab = "Media de solicitudes", 
     main = "Intervalos de Confianza para Solicitudes")

# Agregar líneas para los intervalos
lines(c(1, 1), c(Li.primera.grande, Ls.primera.grande))
lines(c(1.1, 1.1), c(Li.segunda.grande, Ls.segunda.grande), col = "red")
lines(c(2, 2), c(Li.primera.pequeña, Ls.primera.pequeña))
lines(c(2.1, 2.1), c(Li.segunda.pequeña, Ls.segunda.pequeña), col = "red")

# Etiquetas para identificar franjas
text(1, Ls.primera.grande + 0.1, label = "Primera franja (Grande)", col = "blue", pos = 3)
text(1.1, Ls.segunda.grande + 0.1, label = "Segunda franja (Grande)", col = "red", pos = 3)
text(2, Ls.primera.pequeña + 0.1, label = "Primera franja (Pequeña)", col = "blue", pos = 3)
text(2.1, Ls.segunda.pequeña + 0.1, label = "Segunda franja (Pequeña)", col = "red", pos = 3)
#separacion en parejas homosexuales y heterosexuales

#validar que los datos sean numericos ya que si las solicitudes son 0 y les hacemos el logaritmo sale NA (not a number)
parejas.homosexuales.validas.pf<- uniones.primera.franja$Parejas.homosexuales[uniones.primera.franja$Parejas.homosexuales > 0]
parejas.heterosexuales.validas.pf<-uniones.primera.franja$Parejas.heterosexuales[uniones.primera.franja$Parejas.heterosexuales>0]
parejas.homosexuales.validas.sf<-uniones.segunda.franja$Parejas.homosexuales[uniones.segunda.franja$Parejas.homosexuales>0]
parejas.heterosexuales.validas.sf<-uniones.segunda.franja$Parejas.heterosexuales[uniones.segunda.franja$Parejas.homosexuales>0]

primera.franja.homosexuales <- log10(parejas.homosexuales.validas.pf)
primera.franja.heterosexuales <- log10(parejas.heterosexuales.validas.pf)
segunda.franja.homosexuales <- log10(parejas.homosexuales.validas.sf)
segunda.franja.heterosexuales <- log10(parejas.heterosexuales.validas.sf)

total.solicitudes.primera<- sum(solicitudes.primera.muestra.grande.transformadas)

total.parejas.homosexuales.primera.franja <- sum(primera.franja.homosexuales)
total.parejas.homosexuales.segunda.franja<- sum(segunda.franja.homosexuales)
total.parejas.heterosexuales.primera.franja<-sum(primera.franja.heterosexuales)
total.parejas.heterosexuales.segunda.franja<-sum(segunda.franja.heterosexuales)

#suma de las solicitudes totales del grupo grande (con el logaritmo hecho) 
total.primera.franja.grande<-sum(solicitudes.primera.muestra.grande.transformadas)
total.segunda.franja.grande<-sum(solicitudes.segunda.muestra.grande.transformadas)

#suma de las solicitudes totales del grupo pequeño (con el logaritmo hecho)
total.primera.franja.pequeña<-sum(solicitudes.primera.muestra.pequeña.transformadas)
total.segunda.franja.pequeña<- sum(solicitudes.segunda.muestra.pequeña.transformadas)
#proporciones muestrales
(p.primera.franja.homosexuales=total.parejas.homosexuales.primera.franja/total.primera.franja.grande)
10^0.09464197
(p.segunda.franja.homosexuales=total.parejas.homosexuales.segunda.franja/total.primera.franja.grande)
10^1.651662


## Intervalos de confianza
prop.test(total.parejas.homosexuales.primera.franja, total.primera.franja.grande, conf.level = 0.95, correct = FALSE)
10^0.06679966
10^0.13244207
prop.test(total.parejas.homosexuales.segunda.franja,total.segunda.franja.grande, conf.level = 0.95, correct=FALSE)
10^0.09773609
10^0.17021157


#####################Muestras Pequeñas################################
##como necesito coger solo las parejas validas(que tengan solicitudes mayores a 0) tengo que volver a hacer las muestras pequeñas pero solo con datos validos
parejas.homosexuales.muestra.pequeña.pf<-sample(primera.franja.homosexuales,10)
parejas.heterosexuales.muestra.pequeña.pf<-sample(primera.franja.heterosexuales,10)
total.muestra.pequeña.primera.franja=sum(parejas.homosexuales.muestra.pequeña.pf, parejas.heterosexuales.muestra.pequeña.pf)
total.muestra.pequeña.segunda.franja=sum(parejas.homosexuales.muestra.pequeña.sf, parejas.heterosexuales.muestra.pequeña.sf)

total.muestra.pequeña.primera.franja
##segunda franja
parejas.homosexuales.muestra.pequeña.sf<-sample(segunda.franja.homosexuales,10)
parejas.heterosexuales.muestra.pequeña.sf<-sample(segunda.franja.heterosexuales,10)

total.parejas.homosexuales.muestra.pequeña.pf<-sum(parejas.homosexuales.muestra.pequeña.pf)
total.parejas.homosexuales.muestra.pequeña.sf<-sum(parejas.homosexuales.muestra.pequeña.sf)

muestra.completa.pequeña.pf<-c(parejas.homosexuales.muestra.pequeña.pf, parejas.heterosexuales.muestra.pequeña.pf)
mean(muestra.completa.pequeña.pf)
10^1.40
median(muestra.completa.pequeña.pf)
10^1.22
muestra.completa.pequeñas.sf<-c(parejas.homosexuales.muestra.pequeña.sf, parejas.heterosexuales.muestra.pequeña.sf)
mean(muestra.completa.pequeñas.sf)
10^1.59
median(muestra.completa.pequeñas.sf)
10^1.61
##Proporciones muestrales
(p.primera.franja.homosexuales.muestra.pequeña<-total.parejas.homosexuales.muestra.pequeña.pf/total.muestra.pequeña.primera.franja)
10^0.2303739
(p.segunda.franja.homosexuales.muestra.pequeña<-total.parejas.homosexuales.muestra.pequeña.sf/total.muestra.pequeña.segunda.franja)
10^0.3448815

##Intervalos de confianza
prop.test(total.parejas.homosexuales.muestra.pequeña.pf,total.muestra.pequeña.primera.franja,conf.level = 0.95, correct = FALSE)
10^0.1131521
10^0.4125432
prop.test(total.parejas.homosexuales.muestra.pequeña.sf,total.muestra.pequeña.segunda.franja,conf.level = 0.95, correct = FALSE)
10^0.2004009
10^0.5251190


# --- Intervalos de confianza para muestras grandes ---

# Intervalos de confianza para muestras grandes
# Primera franja (Mañana)
test.primera.grande <- prop.test(total.parejas.homosexuales.primera.franja, 
                                 total.primera.franja.grande, 
                                 conf.level = 0.95, correct = FALSE)
Li.primera.grande <- 10^test.primera.grande$conf.int[1]
Ls.primera.grande <- 10^test.primera.grande$conf.int[2]

# Segunda franja (Tarde)
test.segunda.grande <- prop.test(total.parejas.homosexuales.segunda.franja, 
                                 total.segunda.franja.grande, 
                                 conf.level = 0.95, correct = FALSE)
Li.segunda.grande <- 10^test.segunda.grande$conf.int[1]
Ls.segunda.grande <- 10^test.segunda.grande$conf.int[2]

# Intervalos de confianza para muestras pequeñas
# Primera franja (Mañana)
test.primera.pequeña <- prop.test(total.parejas.homosexuales.muestra.pequeña.pf, 
                                  total.muestra.pequeña.primera.franja, 
                                  conf.level = 0.95, correct = FALSE)
Li.primera.pequeña <- 10^test.primera.pequeña$conf.int[1]
Ls.primera.pequeña <- 10^test.primera.pequeña$conf.int[2]

# Segunda franja (Tarde)
test.segunda.pequeña <- prop.test(total.parejas.homosexuales.muestra.pequeña.sf, 
                                  total.muestra.pequeña.segunda.franja, 
                                  conf.level = 0.95, correct = FALSE)
Li.segunda.pequeña <- 10^test.segunda.pequeña$conf.int[1]
Ls.segunda.pequeña <- 10^test.segunda.pequeña$conf.int[2]

# Graficar el diagrama de intervalos de confianza
# Puntos y valores de los intervalos
x <- c(1, 1, 1.1, 1.1, 2, 2, 2.1, 2.1)
y <- c(Li.primera.grande, Ls.primera.grande, 
       Li.segunda.grande, Ls.segunda.grande, 
       Li.primera.pequeña, Ls.primera.pequeña, 
       Li.segunda.pequeña, Ls.segunda.pequeña)

# Crear el gráfico
plot(x, y, xlim = c(0.5, 2.5), ylim = c(0, max(y) + 0.1), 
     xlab = "1 = Muestras grandes, 2 = Muestras pequeñas", 
     ylab = "Proporción de Parejas Homosexuales", 
     main = "Intervalos de Confianza por Franja")

# Agregar líneas para los intervalos
lines(c(1, 1), c(Li.primera.grande, Ls.primera.grande))
lines(c(1.1, 1.1), c(Li.segunda.grande, Ls.segunda.grande), col = "red")
lines(c(2, 2), c(Li.primera.pequeña, Ls.primera.pequeña))
lines(c(2.1, 2.1), c(Li.segunda.pequeña, Ls.segunda.pequeña), col = "red")

# Ajustar etiquetas para identificar franjas
text(1, Ls.primera.grande + 0.05, label = "Primera Franja (Grande)", col = "blue", pos = 3)
text(1.1, Ls.segunda.grande + 0.05, label = "Segunda Franja (Grande)", col = "red", pos = 3)
text(2, Ls.primera.pequeña + 0.05, label = "Primera Franja (Pequeña)", col = "blue", pos = 3)
text(2.1, Ls.segunda.pequeña + 0.05, label = "Segunda Franja (Pequeña)", col = "red", pos = 3)

#---------------------------Parejas Heterosexuales------------------------------------
##Proporciones muestrales
(p.primera.franja.heterosexuales=total.parejas.heterosexuales.primera.franja/total.primera.franja.grande)
10^0.4203953
(p.segunda.franja.heterosexuales=total.parejas.heterosexuales.segunda.franja/total.primera.franja.grande)
10^0.416968

## Intervalos de confianza
prop.test(total.parejas.heterosexuales.primera.franja, total.primera.franja.grande, conf.level = 0.95, correct = FALSE)
10^0.3666575
10^0.4760887
prop.test(total.parejas.heterosexuales.segunda.franja,total.segunda.franja.grande, conf.level = 0.95, correct=FALSE)
10^0.3381558
10^0.4426262



#####################Muestras Pequeñas################################
##como necesito coger solo las parejas validas(que tengan solicitudes mayores a 0) tengo que volver a hacer las muestras pequeñas pero solo con datos validos
p

total.parejas.heterosexuales.muestra.pequeña.pf<-sum(parejas.heterosexuales.muestra.pequeña.pf)
total.parejas.heterosexuales.muestra.pequeña.sf<-sum(parejas.heterosexuales.muestra.pequeña.sf)

##Proporciones muestrales
(p.primera.franja.heterosexuales.muestra.pequeña<-total.parejas.heterosexuales.muestra.pequeña.pf/total.muestra.pequeña.primera.franja)
10^0.7696261
(p.segunda.franja.heterosexuales.muestra.pequeña<-total.parejas.heterosexuales.muestra.pequeña.sf/total.muestra.pequeña.segunda.franja)
10^0.7394658

##Intervalos de confianza
prop.test(total.parejas.heterosexuales.muestra.pequeña.pf,total.muestra.pequeña.primera.franja,conf.level = 0.95, correct = FALSE)
10^0.5874568
10^0.8868479
prop.test(total.parejas.heterosexuales.muestra.pequeña.sf,total.muestra.pequeña.segunda.franja,conf.level = 0.95, correct = FALSE)
10^0.5603185
10^0.8634132


# --- Intervalos de confianza para muestras grandes ---
# Primera franja (Mañana)
ic.grande.primera <- prop.test(total.parejas.heterosexuales.primera.franja, 
                               total.primera.franja.grande, 
                               conf.level = 0.95, correct = FALSE)
lim.inf.grande.primera <- 10^ic.grande.primera$conf.int[1]
lim.sup.grande.primera <- 10^ic.grande.primera$conf.int[2]

# Segunda franja (Tarde)
ic.grande.segunda <- prop.test(total.parejas.heterosexuales.segunda.franja, 
                               total.segunda.franja.grande, 
                               conf.level = 0.95, correct = FALSE)
lim.inf.grande.segunda <- 10^ic.grande.segunda$conf.int[1]
lim.sup.grande.segunda <- 10^ic.grande.segunda$conf.int[2]

# --- Intervalos de confianza para muestras pequeñas ---
# Primera franja (Mañana)
ic.pequeña.primera <- prop.test(total.parejas.heterosexuales.muestra.pequeña.pf, 
                                total.muestra.pequeña.primera.franja, 
                                conf.level = 0.95, correct = FALSE)
lim.inf.pequeña.primera <- 10^ic.pequeña.primera$conf.int[1]
lim.sup.pequeña.primera <- 10^ic.pequeña.primera$conf.int[2]

# Segunda franja (Tarde)
ic.pequeña.segunda <- prop.test(total.parejas.heterosexuales.muestra.pequeña.sf, 
                                total.muestra.pequeña.segunda.franja, 
                                conf.level = 0.95, correct = FALSE)
lim.inf.pequeña.segunda <- 10^ic.pequeña.segunda$conf.int[1]
lim.sup.pequeña.segunda <- 10^ic.pequeña.segunda$conf.int[2]

# --- Graficar el diagrama de intervalos de confianza ---
# Puntos y valores de los intervalos
x <- c(1, 1, 1.1, 1.1, 2, 2, 2.1, 2.1)
y <- c(lim.inf.grande.primera, lim.sup.grande.primera, 
       lim.inf.grande.segunda, lim.sup.grande.segunda, 
       lim.inf.pequeña.primera, lim.sup.pequeña.primera, 
       lim.inf.pequeña.segunda, lim.sup.pequeña.segunda)

# Crear el gráfico
plot(x, y, xlim = c(0.5, 2.5), ylim = c(0, max(y) + 0.1), 
     xlab = "1 = Muestras grandes, 2 = Muestras pequeñas", 
     ylab = "Proporción de Parejas Heterosexuales", 
     main = "Intervalos de Confianza por Franja")

# Agregar líneas para los intervalos
lines(c(1, 1), c(lim.inf.grande.primera, lim.sup.grande.primera))
lines(c(1.1, 1.1), c(lim.inf.grande.segunda, lim.sup.grande.segunda), col = "red")
lines(c(2, 2), c(lim.inf.pequeña.primera, lim.sup.pequeña.primera))
lines(c(2.1, 2.1), c(lim.inf.pequeña.segunda, lim.sup.pequeña.segunda), col = "red")

# Ajustar etiquetas para identificar franjas
text(1, lim.sup.grande.primera + 0.05, label = "Primera Franja (Grande)", col = "blue", pos = 3)
text(1.1, lim.sup.grande.segunda + 0.05, label = "Segunda Franja (Grande)", col = "red", pos = 3)
text(2, lim.sup.pequeña.primera + 0.05, label = "Primera Franja (Pequeña)", col = "blue", pos = 3)
text(2.1, lim.sup.pequeña.segunda + 0.05, label = "Segunda Franja (Pequeña)", col = "red", pos = 3)


###---------------Contrastes de Hipotesis---------------
##medias muestrales
mean(solicitudes.primera.muestra.grande.transformadas)
mean(solicitudes.segunda.muestra.grande.transformadas)

#𝐻0: 𝜇primeraFranja = 𝜇SegundaFranja vs 𝐻𝐴: 𝜇PrimeraFranja != 𝜇SegundaFranja
z.test(solicitudes.primera.muestra.grande.transformadas, solicitudes.segunda.muestra.grande.transformadas, alternative="two.sided", sigma.x=sd(solicitudes.primera.muestra.grande.transformadas), sigma.y=sd(solicitudes.segunda.muestra.grande.transformadas), conf.level=0.95)
#Como p-valor<0.05, se puede aceptar la hipótesis alternativa de que hay diferencia significativa entre
#las medias

# 𝐻0: 𝜇PrimeraFranja = 𝜇SegundaFranja vs 𝐻𝐴: 𝜇PrimeraFranja < 𝜇SegundaFranja
z.test(solicitudes.primera.muestra.grande.transformadas, solicitudes.segunda.muestra.grande.transformadas, alternative="less", sigma.x=sd(solicitudes.primera.muestra.grande.transformadas), sigma.y=sd(solicitudes.segunda.muestra.grande.transformadas), conf.level=0.95)
#Como p-valor<0.05 entoces se puede aceptar la hipotesis alternativa de que la media poblacional de la segunda franja es mayor que la de la segunda
#como ocurre en las medias muestrales

##TEST DE LEVENE
dP=data.frame(SOLICITUDES=solicitudes.primera.muestra.grande.transformadas, FRANJA=rep(c("Primera"),times=length(solicitudes.primera.muestra.grande.transformadas)))
dS=data.frame(SOLICITUDES=solicitudes.segunda.muestra.grande.transformadas, FRANJA=rep(c("Segunda"),times=length(solicitudes.segunda.muestra.grande.transformadas)))
d=rbind(dP,dS)
leveneTest(d$SOLICITUDES,d$FRANJA)

#Como el p-valor(0.3616) es superior a 0.05 se puede suponer que las varianzas son iguales

##muestras pequeñas
mean(solicitudes.primera.muestra.pequeña.transformadas)
mean(solicitudes.segunda.muestra.pequeña.transformadas)
#como la media muestral de la segunda franja es superior a la de la primera franja planteamos la hipotesis de que la media 
#poblacional tambien lo es
dP=data.frame(SOLICITUDES=solicitudes.primera.muestra.pequeña.transformadas, FRANJA=rep(c("Primera"),times=20))
dS=data.frame(SOLICITUDES=solicitudes.segunda.muestra.pequeña.transformadas, FRANJA=rep(c("Segunda"),times=20))
d=rbind(dP,dS)
leveneTest(d$SOLICITUDES,d$FRANJA)
#Como el p-valor(0.6958) es superior a 0.05 se puede suponer que las varianzas son iguales por lo que realizaremos el contraste de hipotesis con t.test

# 𝐻0: 𝜇PrimeraFranja = 𝜇SegundaFranja vs 𝐻𝐴: 𝜇PrimeraFranja < 𝜇SegundaFranja
t.test(solicitudes.primera.muestra.pequeña.transformadas, solicitudes.segunda.muestra.pequeña.transformadas, alternative = "less", var.equal = TRUE, sigma.x=sd(solicitudes.primera.muestra.pequeña.transformadas),sigma.y=sd(solicitudes.segunda.muestra.pequeña.transformadas),conf.level = 0.95)
#como p-valor<0.05 se puede aceptar la hipotesis alternativa tambien en el caso de las muestras pequeñas


#--------------Diferencia de proporciones de solicitudes de se parejas homosexuales----------------
(p.primera.franja.homosexuales=total.parejas.homosexuales.primera.franja/sum(solicitudes.primera.muestra.grande.transformadas))
(p.segunda.franja.homosexuales=total.parejas.homosexuales.segunda.franja/sum(solicitudes.segunda.muestra.grande.transformadas))
#como las proporciones son muestras muy parecidas primero hay que comprobar si hay alguna diferencia
#𝐻0: pHomoPrimera = pHomoSegunda vs 𝐻𝐴: pHomoPrimera ≠ 𝑝HomoSegunda
(prop.test(c(total.parejas.homosexuales.primera.franja, total.parejas.homosexuales.segunda.franja), c(total.primera.franja.grande, total.segunda.franja.grande), alternative="two.sided", conf.level=0.95, correct=FALSE))
#como el p-valor(0.1609) es mayor se no hay diferencia significativa


##muestras pequeñas
(p.primera.franja.homosexuales.muestra.pequeña=total.parejas.homosexuales.muestra.pequeña.pf/total.muestra.pequeña.primera.franja)
(p.segunda.franja.homosexuales.muestra.pequeña=total.parejas.homosexuales.muestra.pequeña.sf/total.muestra.pequeña.segunda.franja)

#𝐻0: 𝑝homoPrimera = 𝑝homoSegunda vs 𝐻𝐴: 𝑝homoPrimera ≠ 𝑝homoSegunda
(prop.test(c(total.parejas.homosexuales.muestra.pequeña.pf, total.parejas.homosexuales.muestra.pequeña.sf),c(total.muestra.pequeña.primera.franja, total.muestra.pequeña.segunda.franja)))
#como p-valor>0.05 no hay evidencias de que haya una diferencia significativa entre la proporcion de parejas homosexuales en la primera y segunda franja


#--------------Diferencia de proporciones de solicitudes de se parejas heterosexuales----------------
(p.primera.franja.heterosexuales=total.parejas.heterosexuales.primera.franja/sum(solicitudes.primera.muestra.grande.transformadas))
(p.segunda.franja.heterosexuales=total.parejas.heterosexuales.segunda.franja/sum(solicitudes.segunda.muestra.grande.transformadas))

#𝐻0: 𝑝heteroPrimera =𝑝heteroSegunda vs 𝐻𝐴: 𝑝heteroPrimera ≠𝑝heteroSegunda
(prop.test(c(total.parejas.heterosexuales.primera.franja, total.parejas.heterosexuales.segunda.franja), c(total.primera.franja.grande, total.segunda.franja.grande), alternative="two.sided", conf.level=0.95, correct=FALSE))
#Como el p-valor(0.0003363)>0.05 entonces se acepta que no hay diferencia significativa

#muestras pequeñas
(p.primera.franja.heterosexuales.muestra.pequeña=total.parejas.heterosexuales.muestra.pequeña.pf/total.muestra.pequeña.primera.franja)
(p.segunda.franja.heterosexuales.muestra.pequeña=total.parejas.heterosexuales.muestra.pequeña.sf/total.muestra.pequeña.segunda.franja)

#𝐻0: 𝑝homoPrimera = 𝑝homoSegunda vs 𝐻𝐴: 𝑝homoPrimera ≠ 𝑝homoSegunda
(prop.test(c(total.parejas.heterosexuales.muestra.pequeña.pf, total.parejas.heterosexuales.muestra.pequeña.sf),c(total.muestra.pequeña.primera.franja, total.muestra.pequeña.segunda.franja)))
#como p-valor>0.05 no hay evidencias de que haya una diferencia significativa entre la proporcion de parejas heterosexuales en la primera y segunda franja

##--------------------------Realizar contrastes de hipotesis no paremetricos------------------
#Contrastes de hipotesis sobre la diferencia de medianas
#MUESTRAS GRANDES
(median(solicitudes.primera.muestra.grande.transformadas))
(median(solicitudes.segunda.muestra.grande.transformadas))
#𝐻0: MsolicitudesPrimera = MsolicitudesSegunda vs 𝐻𝐴: MsolicitudesPrimera ≠ MsolicitudesSegunda
wilcox.test(solicitudes.primera.muestra.grande.transformadas, solicitudes.segunda.muestra.grande.transformadas, paired = FALSE, alternative = "two.sided", conf.level = 0.95, exact = FALSE)
#Como el p-valor < 0.05 se puede aceptar la hipotesis alternativa de que hay diferencia significativa entre las medianas

#𝐻0: MsolicitudesPrimera = MsolicitudesSegunda vs 𝐻𝐴: MsolicitudesPrimera < MsolicitudesSegunda
wilcox.test(solicitudes.primera.muestra.grande.transformadas, solicitudes.segunda.muestra.grande.transformadas, paired = FALSE, alternative = "less", conf.level = 0.95, exact = FALSE)
#Como el pvalor < 0.05 entonces se puede aceptar que la mediana poblacional de la segunda franja es mayor


#MUESTRAS PEQUEÑAS
(median(solicitudes.primera.muestra.pequeña.transformadas))
(median(solicitudes.segunda.muestra.pequeña.transformadas))
#𝐻0: MsolicitudesPrimera = MsolicitudesSegunda vs 𝐻𝐴: MsolicitudesPrimera < MsolicitudesSegunda
wilcox.test(solicitudes.primera.muestra.pequeña.transformadas, solicitudes.segunda.muestra.pequeña.transformadas, paired = FALSE, alternative = "less", conf.level = 0.95, exact = FALSE)
#Como el pvalor < 0.05 entonces se puede aceptar que la mediana poblacional de la segunda franja es mayor

