#Reads in shapefiles and gives example how areas were calculated

Sys.setenv(LANGUAGE='en')
library(tmap)    # for static and interactive maps
library(ggplot2) # tidyverse vis package
library(sf)
library(raster)
library(dplyr)
library(spData)
library(rgeos)
library(geosphere)
library(tidyr)
library(directlabels)
library(gridExtra)
library(RColorBrewer)


# Read in shapefiles ------------------------------------------------------

#C1 all yrs
C1G_16 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_1C_2016.shp")
C1D_16 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_1C_2016.shp")
C1G_17 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_1C_2017.shp")
C1D_17 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_1C_2017.shp")
C1G_18 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_1C_2018.shp")
C1D_18 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_1C_2018.shp")
C1_area <-st_read(dsn = "Data/NaraShapefiles/1C_mask.shp")

#E1 all years
E1G_16 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_1E_2016.shp")
E1D_16 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_1E_2016.shp")
E1G_17 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_1E_2017.shp")
E1D_17 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_1E_2017.shp")
E1G_18 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_1E_2018.shp")
E1D_18 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_1E_2018.shp")
E1_area <-st_read(dsn = "Data/NaraShapefiles/1E_mask.shp")

#C2 all yrs
C2G_16 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_2C_2016UTM.shp")
C2D_16 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_2C_2016UTM.shp")
C2G_17 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_2C_2017UTM.shp")
C2D_17 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_2C_2017UTM.shp")
C2G_18 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_2C_2018UTM.shp")
C2D_18 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_2C_2018UTM.shp")
C2_area <-st_read(dsn = "Data/NaraShapefiles/2C_mask.shp")

#E2 all years
E2G_16 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_2E_2016.shp")
E2D_16 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_2E_2016.shp")
E2G_17 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_2E_2017.shp")
E2D_17 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_2E_2017.shp")
E2G_18 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_2E_2018.shp")
E2D_18 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_2E_2018.shp")
E2_area <-st_read(dsn = "Data/NaraShapefiles/2E_mask.shp")

#C3 all yrs
C3G_16 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_3C_2016.shp")
C3D_16 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_3C_2016.shp")
C3G_17 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_3C_2017.shp")
C3D_17 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_3C_2017.shp")
C3G_18 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_3C_2018.shp")
C3D_18 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_3C_2018.shp")
C3_area <-st_read(dsn = "Data/NaraShapefiles/3C_mask.shp")

#E3 all years
E3G_16 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_3E_2016.shp")
E3D_16 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_3E_2016.shp")
E3G_17 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_3E_2017.shp")
E3D_17 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_3E_2017.shp")
E3G_18 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_3E_2018.shp")
E3D_18 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_3E_2018.shp")
E3_area <-st_read(dsn = "Data/NaraShapefiles/3E_mask.shp")

#C4 all yrs
C4G_16 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_4C_2016.shp")
C4D_16 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_4C_2016.shp")
C4G_17 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_4C_2017.shp")
C4D_17 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_4C_2017.shp")
C4G_18 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_4C_2018.shp")
C4D_18 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_4C_2018.shp")
C4_area <-st_read(dsn = "Data/NaraShapefiles/4C_mask.shp")

#E5 all years
E5G_16 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_4E_2016.shp")
E5D_16 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_4E_2016.shp")
E5G_17 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_4E_2017.shp")
E5D_17 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_4E_2017.shp")
E5G_18 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_4E_2018.shp")
E5D_18 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_4E_2018.shp")
E5_area <-st_read(dsn = "Data/NaraShapefiles/4E_mask.shp")

#C5 all yrs
C5G_16 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_5C_2016.shp")
C5D_16 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_5C_2016.shp")
C5G_17 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_5C_2017.shp")
C5D_17 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_5C_2017.shp")
C5G_18 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_5C_2018.shp")
C5D_18 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_5C_2018.shp")
C5_area <-st_read(dsn = "Data/NaraShapefiles/5C_mask.shp")

#E5 all years
E5G_16 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_5E_2016.shp")
E5D_16 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_5E_2016.shp")
E5G_17 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_5E_2017.shp")
E5D_17 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_5E_2017.shp")
E5G_18 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_5E_2018.shp")
E5D_18 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_5E_2018.shp")
E5_area <-st_read(dsn = "Data/NaraShapefiles/5E_mask.shp")

#C6 all yrs
C6G_16 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_6C_2016.shp")
C6D_16 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_6C_2016.shp")
C6G_17 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_6C_2017.shp")
C6D_17 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_6C_2017.shp")
C6G_18 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_6C_2018.shp")
C6D_18 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_6C_2018.shp")
C6_area <-st_read(dsn = "Data/NaraShapefiles/6C_mask.shp")

#E6 all years
E6G_16 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_6E_2016.shp")
E6D_16 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_6E_2016.shp")
E6G_17 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_6E_2017.shp")
E6D_17 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_6E_2017.shp")
E6G_18 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_6E_2018.shp")
E6D_18 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_6E_2018.shp")
E6_area <-st_read(dsn = "Data/NaraShapefiles/6E_mask.shp")

#C7 all yrs
C7G_16 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_7C_2016.shp")
C7D_16 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_7C_2016.shp")
C7G_17 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_7C_2017.shp")
C7D_17 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_7C_2017.shp")
C7G_18 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_7C_2018.shp")
C7D_18 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_7C_2018.shp")
C7_area <-st_read(dsn = "Data/NaraShapefiles/7C_mask.shp")

#E7 all years
E7G_16 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_7E_2016.shp")
E7D_16 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_7E_2016.shp")
E7G_17 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_7E_2017.shp")
E7D_17 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_7E_2017.shp")
E7G_18 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_7E_2018.shp")
E7D_18 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_7E_2018.shp")
E7_area <-st_read(dsn = "Data/NaraShapefiles/7E_mask.shp")

#C8 all yrs
C8G_16 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_8C_2016.shp")
C8D_16 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_8C_2016.shp")
C8G_17 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_8C_2017.shp")
C8D_17 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_8C_2017.shp")
C8G_18 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_8C_2018.shp")
C8D_18 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_8C_2018.shp")
C8_area <-st_read(dsn = "Data/NaraShapefiles/8C_mask.shp")

#E8 all years
E8G_16 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_8E_2016.shp")
E8D_16 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_8E_2016.shp")
E8G_17 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_8E_2017.shp")
E8D_17 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_8E_2017.shp")
E8G_18 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_8E_2018.shp")
E8D_18 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_8E_2018.shp")
E8_area <-st_read(dsn = "Data/NaraShapefiles/8E_mask.shp")

#C9 all yrs
C9G_16 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_9C_2016.shp")
C9D_16 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_9C_2016.shp")
C9G_17 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_9C_2017.shp")
C9D_17 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_9C_2017.shp")
C9G_18 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_9C_2018.shp")
C9D_18 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_9C_2018.shp")
C9_area <-st_read(dsn = "Data/NaraShapefiles/9C_mask.shp")

#E9 all years
E9G_16 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_9E_2016.shp")
E9D_16 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_9E_2016.shp")
E9G_17 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_9E_2017.shp")
E9D_17 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_9E_2017.shp")
E9G_18 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_9E_2018.shp")
E9D_18 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_9E_2018.shp")
E9_area <-st_read(dsn = "Data/NaraShapefiles/9E_mask.shp")

#C10 all yrs
C10G_16 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_10C_2016.shp")
C10D_16 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_10C_2016.shp")
C10G_17 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_10C_2017.shp")
C10D_17 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_10C_2017.shp")
C10G_18 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_10C_2018.shp")
C10D_18 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_10C_2018.shp")
C10_area <-st_read(dsn = "Data/NaraShapefiles/10C_mask.shp")

#E10 all years
E10G_16 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_10E_2016.shp")
E10D_16 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_10E_2016.shp")
E10G_17 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_10E_2017.shp")
E10D_17 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_10E_2017.shp")
E10G_18 <- st_read(dsn = "Data/NaraShapefiles/TotalGreen_10E_2018.shp")
E10D_18 <- st_read(dsn = "Data/NaraShapefiles/TotalDead_10E_2018.shp")
E10_area <-st_read(dsn = "Data/NaraShapefiles/10E_mask.shp")

################################################################################


# Measure Area of Shapefiles ----------------------------------------------

#This outputs the total area of the selected shapefile (and it's individual sub-polys if you
#remove the sum).  These are just a few examples that I was using to fill in some existing dataframes.
#These data are columns GreenArea and TotalArea in the analysis dataframe.

sum(st_area(C1G_16))
sum(st_area(C1G_17))
sum(st_area(C1G_18))



# Control 1 Plotting ---------------------------------------------------------------
C1_16<- tm_shape(C1_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C1G_16) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C1D_16) +tm_fill(col="darkgrey", alpha=0.8) +
  tm_scale_bar(breaks = c(0, .005, .01), size = 1) +
  tm_layout(title = "C1: 2016") 


C1_17 <- tm_shape(C1_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C1G_17) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C1D_17) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "C1: 2017")

C1_18 <- tm_shape(C1_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C1G_18) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C1D_18) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "C1: 2018")

C1_Green <- tm_shape(C1_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C1G_18) + tm_fill(col= "darkgreen", alpha=0.5) +
  tm_shape(C1G_17) + tm_fill(col= "green", alpha=0.5) +
  tm_shape(C1G_16) + tm_fill(col= "lightgreen", alpha=0.5) +
  #tm_shape(C1G_18) + tm_borders(col= "darkgreen", alpha=1) +
  tm_scale_bar(breaks = c(0, .005, .01), size = 1) +
  tm_layout(title = "C1: Greening, 2016-2018") 




# Exclosure 1 Plotting -------------------------------------------------------------
E1_16<- tm_shape(E1_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E1G_16) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E1D_16) +tm_fill(col="darkgrey", alpha=0.8) +
  tm_scale_bar(breaks = c(0, .005, .01), size = 1) +
  tm_layout(title = "E1: 2016")



E1_17 <- tm_shape(E1_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E1G_17) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E1D_17) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "E1: 2017")

E1_18 <- tm_shape(E1_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E1G_18) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E1D_18) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "E1: 2018")


# Control 2 Plotting ------------------------------------------------------

C2_16<- tm_shape(C2_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C2G_16) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C2D_16) +tm_fill(col="darkgrey", alpha=0.8) +
  tm_scale_bar(breaks = c(0, .005, .01), size = 1) +
  tm_layout(title = "C2: 2016") 


C2_17 <- tm_shape(C2_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C2G_17) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C2D_17) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "C2: 2017")

C2_18 <- tm_shape(C2_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C2G_18) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C2D_18) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "C2: 2018")



# Exclosure 2 Plotting ----------------------------------------------------
E2_16<- tm_shape(E2_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E2G_16) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E2D_16) +tm_fill(col="darkgrey", alpha=0.8) +
  tm_scale_bar(breaks = c(0, .005, .01), size = 1) +
  tm_layout(title = "E2: 2016")



E2_17 <- tm_shape(E2_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E2G_17) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E2D_17) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "E2: 2017")

E2_18 <- tm_shape(E2_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E2G_18) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E2D_18) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "E2: 2018")



# Control 3 Plotting ------------------------------------------------------

C3_16<- tm_shape(C3_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C3G_16) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C3D_16) +tm_fill(col="darkgrey", alpha=0.8) +
  tm_scale_bar(breaks = c(0, .0025, .005), size = 1) +
  tm_layout(title = "C3: 2016") 


C3_17 <- tm_shape(C3_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C3G_17) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C3D_17) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "C3: 2017")

C3_18 <- tm_shape(C3_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C3G_18) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C3D_18) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "C3: 2018")

# Exclosure 3 Plotting ----------------------------------------------------
E3_16<- tm_shape(E3_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E3G_16) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E3D_16) +tm_fill(col="darkgrey", alpha=0.8) +
  tm_scale_bar(breaks = c(0, .0025, .005), size = 1) +
  tm_layout(title = "E3: 2016")



E3_17 <- tm_shape(E3_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E3G_17) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E3D_17) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "E3: 2017")

E3_18 <- tm_shape(E3_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E3G_18) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E3D_18) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "E3: 2018")


# Control 4 Plotting ------------------------------------------------------
C4_16<- tm_shape(C4_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C4G_16) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C4D_16) +tm_fill(col="darkgrey", alpha=0.8) +
  tm_scale_bar(breaks = c(0, .0025, .005), size = 1) +
  tm_layout(title = "C4: 2016") 


C4_17 <- tm_shape(C4_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C4G_17) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C4D_17) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "C4: 2017")

C4_18 <- tm_shape(C4_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C4G_18) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C4D_18) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "C4: 2018")


# Exclosure 4 Plotting ----------------------------------------------------
E4_16<- tm_shape(E4_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E4G_16) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E4D_16) +tm_fill(col="darkgrey", alpha=0.8) +
  tm_scale_bar(breaks = c(0, .0025, .005), size = 1) +
  tm_layout(title = "E4: 2016")



E4_17 <- tm_shape(E4_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E4G_17) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E4D_17) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "E4: 2017")

E4_18 <- tm_shape(E4_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E4G_18) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E4D_18) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "E4: 2018")


# Control 5 Plotting ------------------------------------------------------
C5_16<- tm_shape(C5_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C5G_16) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C5D_16) +tm_fill(col="darkgrey", alpha=0.8) +
  tm_scale_bar(breaks = c(0, .0025, .005), size = 1) +
  tm_layout(title = "C5: 2016") 


C5_17 <- tm_shape(C5_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C5G_17) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C5D_17) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "C5: 2017")

C5_18 <- tm_shape(C5_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C5G_18) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C5D_18) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "C5: 2018")



# Exclosure 5 Plotting ----------------------------------------------------
E5_16<- tm_shape(E5_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E5G_16) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E5D_16) +tm_fill(col="darkgrey", alpha=0.8) +
  tm_scale_bar(breaks = c(0, .0025, .005), size = 1) +
  tm_layout(title = "E5: 2016")



E5_17 <- tm_shape(E5_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E5G_17) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E5D_17) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "E5: 2017")

E5_18 <- tm_shape(E5_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E5G_18) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E5D_18) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "E5: 2018")





# Control 6 Plotting ------------------------------------------------------
C6_16<- tm_shape(C6_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C6G_16) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C6D_16) +tm_fill(col="darkgrey", alpha=0.8) +
  tm_scale_bar(breaks = c(0, .0025, .005), size = 1) +
  tm_layout(title = "C6: 2016") 


C6_17 <- tm_shape(C6_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C6G_17) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C6D_17) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "C6: 2017")

C6_18 <- tm_shape(C6_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C6G_18) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C6D_18) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "C6: 2018")

# Exclosure 6 Plotting ----------------------------------------------------
E6_16<- tm_shape(E6_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E6G_16) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E6D_16) +tm_fill(col="darkgrey", alpha=0.8) +
  tm_scale_bar(breaks = c(0, .0025, .005), size = 1) +
  tm_layout(title = "E6: 2016")



E6_17 <- tm_shape(E6_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E6G_17) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E6D_17) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "E6: 2017")

E6_18 <- tm_shape(E6_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E6G_18) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E6D_18) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "E6: 2018")




# Control 7 Plotting ------------------------------------------------------
C7_16<- tm_shape(C7_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C7G_16) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C7D_16) +tm_fill(col="darkgrey", alpha=0.8) +
  tm_scale_bar(breaks = c(0, .0025, .005), size = 1) +
  tm_layout(title = "C7: 2016") 


C7_17 <- tm_shape(C7_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C7G_17) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C7D_17) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "C7: 2017")

C7_18 <- tm_shape(C7_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C7G_18) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C7D_18) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "C7: 2018")

# Exclosure 7 Plotting ----------------------------------------------------
E7_16<- tm_shape(E7_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E7G_16) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E7D_16) +tm_fill(col="darkgrey", alpha=0.8) +
  tm_scale_bar(breaks = c(0, .0025, .005), size = 1) +
  tm_layout(title = "E7: 2016")



E7_17 <- tm_shape(E7_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E7G_17) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E7D_17) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "E7: 2017")

E7_18 <- tm_shape(E7_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E7G_18) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E7D_18) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "E7: 2018")


# Control 8 Plotting ------------------------------------------------------
C8_16<- tm_shape(C8_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C8G_16) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C8D_16) +tm_fill(col="darkgrey", alpha=0.8) +
  tm_scale_bar(breaks = c(0, .0025, .005), size = 1) +
  tm_layout(title = "C8: 2016") 


C8_17 <- tm_shape(C8_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C8G_17) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C8D_17) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "C8: 2017")

C8_18 <- tm_shape(C8_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C8G_18) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C8D_18) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "C8: 2018")

# Exclosure 8 Plotting ----------------------------------------------------
E8_16<- tm_shape(E8_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E8G_16) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E8D_16) +tm_fill(col="darkgrey", alpha=0.8) +
  tm_scale_bar(breaks = c(0, .0025, .005), size = 1) +
  tm_layout(title = "E8: 2016")



E8_17 <- tm_shape(E8_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E8G_17) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E8D_17) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "E8: 2017")

E8_18 <- tm_shape(E8_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E8G_18) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E8D_18) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "E8: 2018")





# Control 9 Plotting ------------------------------------------------------
C9_16<- tm_shape(C9_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C9G_16) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C9D_16) +tm_fill(col="darkgrey", alpha=0.8) +
  tm_scale_bar(breaks = c(0, .0025, .005), size = 1) +
  tm_layout(title = "C9: 2016") 


C9_17 <- tm_shape(C9_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C9G_17) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C9D_17) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "C9: 2017")

C9_18 <- tm_shape(C9_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C9G_18) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C9D_18) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "C9: 2018")

# Exclosure 9 Plotting ----------------------------------------------------
E9_16<- tm_shape(E9_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E9G_16) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E9D_16) +tm_fill(col="darkgrey", alpha=0.8) +
  tm_scale_bar(breaks = c(0, .0025, .005), size = 1) +
  tm_layout(title = "E9: 2016")



E9_17 <- tm_shape(E9_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E9G_17) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E9D_17) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "E9: 2017")

E9_18 <- tm_shape(E9_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E9G_18) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E9D_18) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "E9: 2018")

# Control 10 Plotting ------------------------------------------------------
C10_16<- tm_shape(C10_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C10G_16) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C10D_16) +tm_fill(col="darkgrey", alpha=0.8) +
  tm_scale_bar(breaks = c(0, .0025, .005), size = 1) +
  tm_layout(title = "C10: 2016") 


C10_17 <- tm_shape(C10_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C10G_17) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C10D_17) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "C10: 2017")

C10_18 <- tm_shape(C10_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(C10G_18) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(C10D_18) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "C10: 2018")

# Exclosure 9 Plotting ----------------------------------------------------
E10_16<- tm_shape(E10_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E10G_16) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E10D_16) +tm_fill(col="darkgrey", alpha=0.8) +
  tm_scale_bar(breaks = c(0, .0025, .005), size = 1) +
  tm_layout(title = "E10: 2016")



E10_17 <- tm_shape(E10_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E10G_17) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E10D_17) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "E10: 2017")

E10_18 <- tm_shape(E10_area) + tm_fill(col= "cornsilk", alpha=0.6) +
  tm_borders() +
  tm_shape(E10G_18) + tm_fill(col= "darkgreen", alpha=0.6) +
  tm_shape(E10D_18) +tm_fill(col="darkgrey", alpha=0.8)+
  tm_layout(title = "E10: 2018")


# Execute Plots -----------------------------------------------------------
tmap_options(check.and.fix = TRUE)
#Individual plots
tmap_arrange(C1_16, C1_17, C1_18, E1_16, E1_17, E1_18)
tmap_arrange(C2_16, C2_17, C2_18, E2_16, E2_17, E2_18)
tmap_arrange(C3_16, C3_17, C3_18, E3_16, E3_17, E3_18)
tmap_arrange(C4_16, C4_17, C4_18, E4_16, E4_17, E4_18)
tmap_arrange(C5_16, C5_17, C5_18, E5_16, E5_17, E5_18)
tmap_arrange(C6_16, C6_17, C6_18, E6_16, E6_17, E6_18)
tmap_arrange(C7_16, C7_17, C7_18, E7_16, E7_17, E7_18)
tmap_arrange(C8_16, C8_17, C8_18, E8_16, E8_17, E8_18)
tmap_arrange(C9_16, C9_17, C9_18, E9_16, E9_17, E9_18)
tmap_arrange(C10_16, C10_17, C10_18, E10_16, E10_17, E10_18)

