if(!require(readxl)) install.packages("readxl")
library(readxl)
if(!require(rJava)) install.packages("rJava")
library(rJava)
if(!require(xlsxjars)) install.packages("xlsxjars")
library(xlsxjars)
library("xlsx")

#abrir archivo deleciones

setwd("C:/Users/marta/OneDrive/Desktop/Máster/Trabajo Fin de Máster/Parte_informatica_TFM/Scripts_definitivos/Perc_Del")

Deleciones <- read.csv("C:/Users/marta/OneDrive/Desktop/Máster/Trabajo Fin de Máster/Parte_informatica_TFM/Datos/allDels.csv")
View (Deleciones)
#funcion para sacar los % de cada gen

getdelpercentajes <- function(genes,lin, perc){
  subDels <- Deleciones[match(genes, Deleciones$gene), grep(lin, colnames(Deleciones))]
  subDelsBin <- apply(subDels, 2, function(x) x > perc)
  percDel <- apply(subDelsBin, 1, function(x) sum(x)/ncol(subDelsBin)*100)
  names(percDel) <- genes
  return(percDel)
}

#Cargar el archivo que contiene los genes de resistencia a Cu que presentan deleciones y definir el % a partir del cual se considera que hay deleción
genes_Cu <-  read.csv("C:/Users/marta/OneDrive/Desktop/Máster/Trabajo Fin de Máster/Parte_informatica_TFM/Scripts_definitivos/Deleciones_Resistencia_Cu_definitivo.csv")
genes <- c(genes_Cu$gene)
perc <- 0.01

#Probar con A1
A1 <- getdelpercentajes(genes = genes, lin = "A1", perc = perc)
View (A1)
as.data.frame(A1)
names (A1)
matriz <- matrix(A1, ncol = 1)
View (matriz)
A1_rownames <- c(genes_Cu$gene)
rownames(matriz) <- A1_rownames
View(matriz)
A1_colnames <- ("A1")
colnames(matriz) <- A1_colnames
View (matriz)
grep("A1", colnames(Deleciones))

#Hacer para todos los linajes

A2 <- getdelpercentajes(genes = genes, lin = "A2", perc = perc)
A3 <- getdelpercentajes(genes = genes, lin = "A3", perc = perc)
A4 <- getdelpercentajes(genes = genes, lin = "A4", perc = perc)
L1 <- getdelpercentajes(genes = genes, lin = "L1", perc = perc)
L2 <- getdelpercentajes(genes = genes, lin = "L2", perc = perc)
L3 <- getdelpercentajes(genes = genes, lin = "L3", perc = perc)
L4 <- getdelpercentajes(genes = genes, lin = "L4", perc = perc)
L5 <- getdelpercentajes(genes = genes, lin = "L5", perc = perc)
L6 <- getdelpercentajes(genes = genes, lin = "L6", perc = perc)
L7 <- getdelpercentajes(genes = genes, lin = "L7", perc = perc)
L8 <- getdelpercentajes(genes = genes, lin = "L8", perc = perc)
L9 <- getdelpercentajes(genes = genes, lin = "L9", perc = perc)


Perc_Del_Cu = data.frame (
  A1 = c(A1),
  A2 = c(A2),
  A3 = c(A3), 
  A4 = c(A4),
  L1 = c(L1),
  L2 = c(L2),
  L3 = c(L3),
  L4 = c(L4),
  L5 = c(L5),
  L6 = c(L6),
  L7 = c(L7),
  L8 = c(L8),
  L9 = c(L9))

View (Perc_Del_Cu)
setwd("C:/Users/marta/OneDrive/Desktop/Máster/Trabajo Fin de Máster/Parte_informatica_TFM/Scripts_definitivos/Perc_Del")
write.xlsx(Perc_Del_Cu,file = "Perc_Del_Cu.xlsx")
