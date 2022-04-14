#Reads in shapefiles, calculates cover area, and plots Sup Fig 3.

Sys.setenv(LANGUAGE='en')
library(tmap)   
library(ggplot2)
library(sf)
library(dplyr)
library(spData)
library(rgeos)
library(geosphere)
library(tidyr)
library(directlabels)
library(gridExtra)
library(RColorBrewer)
library(stringr)
library(ggspatial)
library(stars)
library(precrec)
library(gtools)
library(magick)


# List of shapefiles ------------------------------------------------------

Green.ls <- list.files(path='Data/NaraShapefiles', pattern='TotalGreen.*\\.shp$', full.names = TRUE)

Green.ls<-mixedsort(Green.ls)

Hummock.ls <-list.files(path='Data/NaraShapefiles', pattern='mask.*\\.shp$', full.names = TRUE)

# Read in shapefiles ------------------------------------------------------

Nara_Green_Area <- function(greenname){
  year<- str_sub(greenname, -8,-5)
  site<- str_match(greenname, "TotalGreen_\\s*(.*?)\\s*_201")[,2]
  temp<-NULL
  temp$site<-site
  temp$year<-year
  temp$site_year<-paste0(site,'_',year)
  t1<-st_read(greenname, quiet=TRUE)
  temp$greenarea<-as.numeric(sum(st_area(t1)))
  temp<-data.frame(temp)
  return(temp) 
}

# Calculate areas ---------------------------------------------------------
 
GreenArea<-do.call(rbind, lapply(X=Green.ls, FUN=Nara_Green_Area))

Nara_data<-GreenArea%>% pivot_wider(id_cols=site, names_from= year, values_from=greenarea, names_prefix = 'GreenArea_',)

Nara_Hum_Area <- function(humname){
  temp2<-NULL
  temp2$site<- str_match(humname, "s/\\s*(.*?)\\s*_")[,2]
  t2<-st_read(humname, quiet=TRUE)
  temp2$humarea<-as.numeric(sum(st_area(t2)))
  temp<-data.frame(temp2)
  return(temp2) 
}

HumArea<-data.frame(do.call(rbind, lapply(X=Hummock.ls, FUN=Nara_Hum_Area)))

HumArea$site<-unlist(HumArea$site)
HumArea$humarea<-unlist(HumArea$humarea)

Nara_data<-left_join(Nara_data, HumArea, by = 'site')

Nara_data$Gr18m17.17Green<-(Nara_data$GreenArea_2018-Nara_data$GreenArea_2017)/Nara_data$GreenArea_2017
Nara_data$Gr17m16.16Green<-(Nara_data$GreenArea_2017-Nara_data$GreenArea_2016)/Nara_data$GreenArea_2016

write.csv(Nara_data, 'Data/NaraMultiYearArea_Data.csv')


# Supplementary Fig3 Plotting Orthos and Cover ---------------------------------------------------------------

#Edit to your local path once imagery are downloaded. 
#Imagery is locaaed here:
Nara_Path<-'U:/Namibia_Imagery_Data/N_Orthos_UTM/'

#Function to make individual cover plots
Nara_Sites <- function(greenname){
  year<- str_sub(greenname, -8,-5)
  site<- str_match(greenname, "TotalGreen_\\s*(.*?)\\s*_201")[,2]
  siteyr <-paste0(site,"_",year)
  Nara_G<-st_read(paste0("Data/NaraShapefiles/TotalGreen_",siteyr,".shp"))
  Nara_A<-st_read(paste0("Data/NaraShapefiles/", site,"_mask.shp"))
  tmap_options(check.and.fix = TRUE)
  nar_plot<-tm_shape(Nara_A, unit ='m')+ tm_fill(col= "cornsilk", alpha=0.6) +
    tm_borders() +
    tm_shape(Nara_G) + tm_fill(col= "darkgreen", alpha=0.6) +
    tm_layout(main.title = siteyr, frame = FALSE, main.title.position = "center",
              inner.margins = c(0.2, 0.02, 0.02, 0.02))+
    tm_scale_bar(breaks = 5, position=c("left", "bottom"), lwd = 2, text.size = 1) 
    
  tmap_save(nar_plot, file=paste0("Figures/SuppFigs/SupFig1_cover", siteyr,".png"), width = 4, height = 4, dpi = 600, units = "in")
}

#Get list of ortho tifs
Ortho.ls <-list.files(path=Nara_Path, pattern='Nara.*\\.tif$', full.names = TRUE)
Ortho.ls<-mixedsort(Ortho.ls)

#Function to make individual ortho plots
Nara_Rasters <- function(orthoname){
  year<- str_sub(orthoname, -12,-9)
  site<- str_match(orthoname, "Nara_\\s*(.*?)\\s*_201")[,2]
  siteyr <-paste0(site,"_",year)
  Nara_Ortho<-read_stars(paste0(Nara_Path,"Nara_",siteyr,"_UTM.tif"))
  nar_plot<-tm_shape(Nara_Ortho, unit ='m')+ 
    tm_rgb() +
    tm_layout(main.title = siteyr, frame = FALSE, main.title.position = "center",
              inner.margins = c(0.2, 0.02, 0.02, 0.02))+
    tm_scale_bar(breaks = 5, position=c("left", "bottom"), lwd = 2, text.size = 1) 
  
  tmap_save(nar_plot, file=paste0("Figures/SuppFigs/SupFig1_orthos/SupFig1_ortho", siteyr,".png"), width = 4, height = 4, dpi = 600, units = "in")
}

#Apply function to ortho file list
lapply(Ortho.ls, Nara_Rasters)  

#Get list of all cover plots created by above function  
coverfiles <-
  list.files(
    path = here::here("Figures/SuppFigs/SupFig1_cover"),
    recursive = TRUE,
    pattern = "\\.png$",
    full.names = T
  )

#Organize them for easier plotting
coverfiles<-mixedsort(coverfiles)

#Ger list of all orho plots created by above function
orthofiles <-
  list.files(
    path = here::here("Figures/SuppFigs/SupFig1_orthos"),
    recursive = TRUE,
    pattern = "\\.png$",
    full.names = T
  )

#Organize them for easier plotting
orthofiles<-mixedsort(orthofiles)

#Make composite figures for cover
magick::image_read(coverfiles) %>%
  magick::image_montage(tile = "6", geometry = "x500+10+5") %>%
  magick::image_convert("jpg") %>%
  magick::image_write(
    format = ".jpg", path = here::here(paste("Figures/SuppFigs/SuppFig1_cover.jpg",sep="")),
    quality = 100
  )

#Make composite figure for orthos
magick::image_read(orthofiles) %>%
  magick::image_montage(tile = "6", geometry = "x500+10+5") %>%
  magick::image_convert("jpg") %>%
  magick::image_write(
    format = ".jpg", path = here::here(paste("Figures/SuppFigs/SuppFig1_orthos.jpg",sep="")),
    quality = 100
  )

