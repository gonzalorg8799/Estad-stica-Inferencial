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
solicitudes.primera.muestra.grande.transformadas=log(solicitudes.primera.muestra.grande)
solicitudes.segunda.muestra.grande.transformadas=log(solicitudes.segunda.muestra.grande)
solicitudes.primera.muestra.pequeña.transformadas=log(solicitudes.primera.muestra.pequeña)
solicitudes.segunda.muestra.pequeña.transformadas=log(solicitudes.segunda.muestra.pequeña)

#comprobacion de los datos transformados
jarque.bera.test(solicitudes.primera.muestra.grande.transformadas)
jarque.bera.test(solicitudes.segunda.muestra.grande.transformadas)
par(mfrow=c(1,2))
qqPlot(solicitudes.primera.muestra.grande.transformadas, main = "Primera_franja")
qqPlot(solicitudes.segunda.muestra.grande.transformadas, main = "Segunda_franja")

##histogramas
L=c(34,80,200,300,581)
hist(solicitudes.primera.muestra.grande.transformadas, breaks = L, main="Primera franja (muestra pequeña)",
     ylim=c(0,1000), ylab = "", xlab = "Solicitudes", freq = FALSE)
curve(dnorm(x,mean(solicitudes.primera.muestra.grande.transformadas),sd(solicitudes.primera.muestra.grande.transformadas)),0,600,
      add=TRUE, col="red")
hist(solicitudes.segunda.muestra.pequeña, breaks = L, main="Segunda franja (muestra pequeña)",
     ylim=c(0,0.4), ylab = "", xlab = "Solicitudes", freq = FALSE)
curve(dnorm(x,mean(solicitudes.segunda.muestra.pequeña),sd(solicitudes.segunda.muestra.pequeña)),0,12,
      add=TRUE, col="red")

#Intervalos de confianza para la media
install.packages("BSDA")
library(BSDA)
z.test(solicitudes.primera.muestra.grande.transformadas, sigma.x = sd(solicitudes.primera.muestra.grande.transformadas), conf.level = 0.95)
z.test(solicitudes.segunda.muestra.grande.transformadas, sigma.x = sd(solicitudes.segunda.muestra.grande.transformadas), conf.level = 0.95)

#Intervalos de confianza para datos pequeños
t.test(solicitudes.primera.muestra.pequeña.transformadas, conf.level = 0.95)
t.test(solicitudes.segunda.muestra.pequeña.transformadas,conf.level = 0.95)

#Diagrama de intervalos
test.M.grande=z.test(notaM.muestra.grande, sigma.x=sd(notaM.muestra.grande),conf.level=0.95)
Li.M.grande=test.M.grande$conf.int[1]
Ls.M.grande=test.M.grande$conf.int[2]
test.T.grande=z.test(notaT.muestra.grande, sigma.x=sd(notaT.muestra.grande),
                     conf.level=0.95)
Li.T.grande=test.T.grande$conf.int[1]
Ls.T.grande=test.T.grande$conf.int[2]
test.M.pequeña=t.test(notaM.muestra.pequeña, conf.level=0.95)
Li.M.pequeña=test.M.pequeña$conf.int[1]
Ls.M.pequeña=test.M.pequeña$conf.int[2]
test.T.pequeña=t.test(notaT.muestra.pequeña, conf.level=0.95)
Li.T.pequeña=test.T.pequeña$conf.int[1]
Ls.T.pequeña=test.T.pequeña$conf.int[2]
plot(c(1,1,1.1,1.1,2,2,2.1,2.1),c(Li.M.grande, Ls.M.grande, Li.T.grande,Ls.T.grande, Li.M.pequeña, Ls.M.pequeña, Li.T.pequeña, Ls.T.pequeña), xlim =c(0,4), xlab = "1=Muestras grandes, 2=muestras pequeñas", ylab = "Nota")
lines(c(1,1),c(Li.M.grande,Ls.M.grande))
lines(c(1.1,1.1),c(Li.T.grande,Ls.T.grande),col="red")
lines(c(2,2),c(Li.M.pequeña,Ls.M.pequeña))
lines(c(2.1,2.1),c(Li.T.pequeña,Ls.T.pequeña),col="red")
text(0.7, 8.5, label = "Mañana")
text(1.3, 7.5, label = "Tarde")
text(1.7, 8.5, label = "Mañana")
text(2.3, 7.5, label = "Tarde")



# --- Intervalos de confianza para muestras grandes ---
# Primera franja
test.primera.grande <- z.test(solicitudes.primera.muestra.grande.transformadas,
                              sigma.x = sd(solicitudes.primera.muestra.grande.transformadas), 
                              conf.level = 0.95)
Li.primera.grande <- test.primera.grande$conf.int[1]
Ls.primera.grande <- test.primera.grande$conf.int[2]

# Segunda franja
test.segunda.grande <- z.test(solicitudes.segunda.muestra.grande.transformadas,
                              sigma.x = sd(solicitudes.segunda.muestra.grande.transformadas), 
                              conf.level = 0.95)
Li.segunda.grande <- test.segunda.grande$conf.int[1]
Ls.segunda.grande <- test.segunda.grande$conf.int[2]

# --- Intervalos de confianza para muestras pequeñas ---
# Primera franja
test.primera.pequeña <- t.test(solicitudes.primera.muestra.pequeña.transformadas, conf.level = 0.95)
Li.primera.pequeña <- test.primera.pequeña$conf.int[1]
Ls.primera.pequeña <- test.primera.pequeña$conf.int[2]

# Segunda franja
test.segunda.pequeña <- t.test(solicitudes.segunda.muestra.pequeña.transformadas, conf.level = 0.95)
Li.segunda.pequeña <- test.segunda.pequeña$conf.int[1]
Ls.segunda.pequeña <- test.segunda.pequeña$conf.int[2]

# --- Graficar los intervalos de confianza ---
# Definir puntos y límites para el gráfico
x <- c(1, 1, 1.1, 1.1, 2, 2, 2.1, 2.1)
y <- c(Li.primera.grande, Ls.primera.grande, 
       Li.segunda.grande, Ls.segunda.grande, 
       Li.primera.pequeña, Ls.primera.pequeña, 
       Li.segunda.pequeña, Ls.segunda.pequeña)

# Crear el gráfico
plot(x, y, xlim = c(0.5, 2.5), ylim = c(min(y) - 0.5, max(y) + 0.5), 
     xlab = "1 = Muestras grandes, 2 = Muestras pequeñas", 
     ylab = "Log de Solicitudes", 
     main = "Intervalos de Confianza para Solicitudes")

# Agregar líneas para los intervalos
lines(c(1, 1), c(Li.primera.grande, Ls.primera.grande))
lines(c(1.1, 1.1), c(Li.segunda.grande, Ls.segunda.grande), col = "red")
lines(c(2, 2), c(Li.primera.pequeña, Ls.primera.pequeña))
lines(c(2.1, 2.1), c(Li.segunda.pequeña, Ls.segunda.pequeña), col = "red")

# Etiquetas para identificar franjas
text(0.7, max(y) - 0.5, label = "Primera franja", col = "blue")
text(1.3, max(y) - 0.5, label = "Segunda franja", col = "red")

#separacion en parejas homosexuales y heterosexuales

#validar que los datos sean numericos ya que si las solicitudes son 0 y les hacemos el logaritmo sale NA (not a number)
parejas.homosexuales.validas.pf<- uniones.primera.franja$Parejas.homosexuales[uniones.primera.franja$Parejas.homosexuales > 0]
parejas.heterosexuales.validas.pf<-uniones.primera.franja$Parejas.heterosexuales[uniones.primera.franja$Parejas.heterosexuales>0]
parejas.homosexuales.validas.sf<-uniones.segunda.franja$Parejas.homosexuales[uniones.segunda.franja$Parejas.homosexuales>0]
parejas.heterosexuales.validas.sf<-uniones.segunda.franja$Parejas.heterosexuales[uniones.segunda.franja$Parejas.homosexuales>0]

primera.franja.homosexuales <- log(parejas.homosexuales.validas.pf)
primera.franja.heterosexuales <- log(parejas.heterosexuales.validas.pf)
segunda.franja.homosexuales <- log(parejas.homosexuales.validas.sf)
segunda.franja.heterosexuales <- log(parejas.heterosexuales.validas.sf)

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
p.primera.franja.homosexuales=total.parejas.homosexuales.primera.franja/length(solicitudes.primera.muestra.grande.transformadas)
p.segunda.franja.homosexuales=total.parejas.homosexuales.segunda.franja/length(solicitudes.segunda.muestra.grande.transformadas)


## Intervalos de confianza
prop.test(total.parejas.homosexuales.primera.franja, total.primera.franja.grande, conf.level = 0.95, correct = FALSE)

prop.test(total.parejas.homosexuales.segunda.franja,total.segunda.franja.grande, conf.level = 0.95, correct=FALSE)



#####################Muestras Pequeñas################################
##como necesito coger solo las parejas validas(que tengan solicitudes mayores a 0) tengo que volver a hacer las muestras pequeñas pero solo con datos validos
parejas.homosexuales.muestra.pequeña.pf<-sample(primera.franja.homosexuales,20)
parejas.heterosexuales.muestra.pequeña.pf<-sample(primera.franja.heterosexuales,20)

##segunda franja
parejas.homosexuales.muestra.pequeña.sf<-sample(segunda.franja.homosexuales,20)
parejas.heterosexuales.muestra.pequeña.sf<-sample(segunda.franja.heterosexuales,20)

total.parejas.homosexuales.muestra.pequeña.pf<-sum(parejas.homosexuales.muestra.pequeña.pf)

