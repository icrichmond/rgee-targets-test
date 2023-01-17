library(renv)
library(targets)
library(tarchetypes)

library(data.table)



# rgee --------------------------------------------------------------------
library(sf)

library(rgee)
ee_Initialize()

# For ee_extract, first for V8 (on amd64/arm64 Linux/MacOS)
Sys.setenv(DOWNLOAD_STATIC_LIBV8 = 1)
library(geojsonio)


library(devtools)
library(pkgdown)
