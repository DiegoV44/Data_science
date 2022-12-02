library(readxl)
library(tidyverse)
library(lubridate)
library(zoo)

# Extracción y limpieza de datos
# Se cambió el nombre de las columnas y se formatearon las columnas con read_excel

CPI_nuevo <- read_excel("CPI Nuevo.xls", col_names = c("fecha", "CPI nuevo"),
           col_types = c("date", "numeric"))
var_CPI_nuevo <- read_excel("var cpi nuevo.xls", col_names = c("fecha", "var CPI nuevo"),
                        col_types = c("date", "numeric"))
var_CPI_usado <- read_excel("var cpi usado.xls", col_names = c("fecha", "var CPI usado"),
                        col_types = c("date", "numeric"))
produccion <- read_excel("produccion.xls", col_names = c("fecha", "produccion"),
                        col_types = c("date", "numeric"))

# Se removieron los NA con filter y is.na

var_CPI_nuevo <- filter(var_CPI_nuevo, !is.na(fecha))
var_CPI_usado <- filter(var_CPI_usado, !is.na(fecha))
produccion <- filter(produccion, !is.na(fecha))
CPI_nuevo <- filter(CPI_nuevo, !is.na(fecha))

# Se juntaron todos los datos con un pipe y left_join, para luego guardar un archivo con la tabla
# dentro del enviroment para fácil referencia en el archivo RMarkdown

vehiculos <- var_CPI_nuevo %>%
  left_join(var_CPI_usado, by = "fecha") %>%
  left_join(produccion, by = "fecha") %>%
  left_join(CPI_nuevo, by = "fecha")

save(vehiculos, file = "vehiculos.RData")
