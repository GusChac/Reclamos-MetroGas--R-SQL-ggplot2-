setwd("/Users/gustavochac/Downloads")
list.files()
Gas2019 <- read.csv('reclamos_enargas_2019.csv',encoding = "UTF-8")
library(SQLite)
library(gsubfn)
library(proto)
library(sqldf)

reclamos_CABA_2019 <- sqldf("SELECT *
                       FROM Gas2019
                       WHERE reclamo_provincia = 'Ciudad Autónoma de Buenos Aires'")
sqldf("SELECT count() FROM reclamos_CABA_2019")
sqldf("SELECT count() FROM reclamos_CABA_2019 WHERE reclamo_resolucion = 'Procedente'")
sqldf("SELECT count() FROM reclamos_CABA_2019 WHERE reclamo_resolucion = 'Improcedente'")

Gas2020 <- read.csv('reclamos_enargas_2020.csv',encoding = "UTF-8")
reclamos_CABA_2020 <- sqldf("SELECT *
                       FROM Gas2020
                       WHERE reclamo_provincia = 'Ciudad Autónoma de Buenos Aires'")
sqldf("SELECT count() FROM reclamos_CABA_2020")
sqldf("SELECT count() FROM reclamos_CABA_2020 WHERE reclamo_resolucion = 'Procedente'")
sqldf("SELECT count() FROM reclamos_CABA_2020 WHERE reclamo_resolucion = 'Improcedente'")

reclamos_CABA <- merge(reclamos_CABA_2019,reclamos_CABA_2020, all = TRUE)

#### ESTUDIO 2019
# EL ESTUDIO CONSTARA DE EVALUAR LOS RECLAMOS PROCEDENTES E IMPROCEDENTES Y LUEGO VERIFICAR SU ORIGEN Y MOTIVO
# PARA FINALIZAR HACIENDO UNA COMPARACION CON EL 2020 de lo mismo

#### VERIFICACION DE RECLAMOS PROCEDENTES/IMPROCENDENTES

a11 <- sqldf("SELECT count() FROM reclamos_CABA_2019 WHERE reclamo_resolucion = 'Procedente'")
a21 <- sqldf("SELECT count() FROM reclamos_CABA_2019 WHERE reclamo_resolucion = 'Improcedente'")
tot <- sqldf("SELECT count() FROM reclamos_CABA_2019")

PI2019 <- matrix(c(a11,a21,tot,a11/tot,a21/tot,1),nrow=3,ncol=2,byrow=F)

#### EVALUACION PROCEDENTE

reclamos_procedentes_2019 <- sqldf("SELECT * FROM reclamos_CABA_2019 WHERE reclamo_resolucion = 'Procedente'")
sqldf("SELECT sum(reclamo_cantidad) FROM reclamos_procedentes_2019")

#### ESTUDIO 2020

#### VERIFICACION DE RECLAMOS PROCEDENTES/IMPROCENDENTES

a11 <- sqldf("SELECT count() FROM reclamos_CABA_2020 WHERE reclamo_resolucion = 'Procedente'")
a21 <- sqldf("SELECT count() FROM reclamos_CABA_2020 WHERE reclamo_resolucion = 'Improcedente'")
tot <- sqldf("SELECT count() FROM reclamos_CABA_2020")

PI2020 <- matrix(c(a11,a21,tot,a11/tot,a21/tot,1),nrow=3,ncol=2,byrow=F)

h <- 0
for(i in 1:230) {
  h <- h + as.numeric(reclamos_procedentes_2019$reclamo_cantidad[i])
}
class(reclamos_procedentes_2019$reclamo_cantidad[i])
