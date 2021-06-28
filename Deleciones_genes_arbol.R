#Buscar deleciones de resistencia a Cu, PZA, POA para BCG TICE, Russian y Pasteur (cepas lab)

if(!require(readxl)) install.packages("readxl")
library(readxl)
if(!require(rJava)) install.packages("rJava")
library(rJava)
if(!require(xlsxjars)) install.packages("xlsxjars")
library(xlsxjars)
library("xlsx")


#Cargar el archivo con los genes de resistencia que voy a poner en el árbol

setwd("C:/Users/marta/OneDrive/Desktop/Máster/Trabajo Fin de Máster/Parte_informatica_TFM/Scripts_definitivos/Deleciones_arbol")   
Resistencia_lab <- read_xlsx("C:/Users/marta/OneDrive/Desktop/Máster/Trabajo Fin de Máster/Parte_informatica_TFM/Búsqueda_genes/Genes_resistencia_micobacterias.xlsx",sheet=6)
as.data.frame(read_xlsx("C:/Users/marta/OneDrive/Desktop/Máster/Trabajo Fin de Máster/Parte_informatica_TFM/Búsqueda_genes/Genes_resistencia_micobacterias.xlsx",sheet=6))

#Modificar el objeto para que tenga solo las filas/columnas de interés

View(Resistencia_lab)
Resistencia_lab <- Resistencia_lab [,2:6]
View(Resistencia_lab)

#Cargar el archivo de deleciones
setwd("C:/Users/marta/OneDrive/Desktop/Máster/Trabajo Fin de Máster/Parte_informatica_TFM/Scripts_definitivos/Deleciones_arbol")
Deleciones <- read.csv("C:/Users/marta/OneDrive/Desktop/Máster/Trabajo Fin de Máster/Parte_informatica_TFM/Datos/allDels.csv")
View(Deleciones)

#Comparar los dos archivos para ver que genes de resistencia a  presentan una deleción
Deleciones_TF <- Deleciones$gene%in%Resistencia_lab$Rv
View(Deleciones_TF)
write.xlsx(Deleciones_TF, file = "Deleciones(T-F).xlsx")

#Añadir el código Rv a las filas que pone TRUE/FALSE
setwd("C:/Users/marta/OneDrive/Desktop/Máster/Trabajo Fin de Máster/Parte_informatica_TFM/Scripts_definitivos/Deleciones_arbol")
Resistencia_TF <- read_xlsx("C:/Users/marta/OneDrive/Desktop/Máster/Trabajo Fin de Máster/Parte_informatica_TFM/Scripts_definitivos/Deleciones_arbol/Deleciones(T-F).xlsx")
as.data.frame(read_xlsx("C:/Users/marta/OneDrive/Desktop/Máster/Trabajo Fin de Máster/Parte_informatica_TFM/Scripts_definitivos/Deleciones_arbol/Deleciones(T-F).xlsx"))
Deleciones_Rownames <- Deleciones[,1]
View(Deleciones_Rownames)
Resistencia_TF <- Resistencia_TF[,2]
rownames(Resistencia_TF)<- Deleciones_Rownames
View(Resistencia_TF)
write.xlsx(Resistencia_TF,file = "Resistencia_TF_Rv.xlsx")

#Poner nombre a las columnas del archivo que tiene TRUE/FALSE con los Rv
setwd("C:/Users/marta/OneDrive/Desktop/Máster/Trabajo Fin de Máster/Parte_informatica_TFM/Scripts_definitivos/Deleciones_arbol")
Resistencia_TF <- read_xlsx("C:/Users/marta/OneDrive/Desktop/Máster/Trabajo Fin de Máster/Parte_informatica_TFM/Scripts_definitivos/Deleciones_arbol/Resistencia_TF_Rv.xlsx")
as.data.frame(read_xlsx("C:/Users/marta/OneDrive/Desktop/Máster/Trabajo Fin de Máster/Parte_informatica_TFM/Scripts_definitivos/Deleciones_arbol/Resistencia_TF_Rv.xlsx"))
View(Resistencia_TF)
Resistencia_TF_Rownames <-c("Rv","common")
colnames(Resistencia_TF) <- Resistencia_TF_Rownames
View(Resistencia_TF)

#Crear un objeto "comunes" que contiene unicamente los genes comunes, los que tiene TRUE en la columna de "common"
Resistencia_Comunes <- Resistencia_TF[Resistencia_TF$common==TRUE, ]
View(Resistencia_Comunes)

#Ahora pondré nombre a las columnas y completaré las columnas que faltan
DelecionesFinal<-Deleciones[Deleciones$gene%in%Resistencia_Comunes$Rv,"G01551" ]
View(DelecionesFinal)

setwd("C:/Users/marta/OneDrive/Desktop/Máster/Trabajo Fin de Máster/Parte_informatica_TFM/Scripts_definitivos/Deleciones_arbol")
write.csv(DelecionesFinal,file = "Deleciones_Resistencia_definitivo.csv")

setwd("C:/Users/marta/OneDrive/Desktop/Máster/Trabajo Fin de Máster/Parte_informatica_TFM/Scripts_definitivos/Deleciones_arbol")
Deleciones_arbol <- read.csv("C:/Users/marta/OneDrive/Desktop/Máster/Trabajo Fin de Máster/Parte_informatica_TFM/Scripts_definitivos/Deleciones_arbol/Deleciones_Resistencia_definitivo.csv")
View(Deleciones_arbol)
