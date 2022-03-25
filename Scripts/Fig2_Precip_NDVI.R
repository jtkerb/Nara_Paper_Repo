##Code the produces the building blocks of Figure 2.
##Runs on a PC

library(ggplot2)
library(dplyr)
library(lubridate)
library(gridExtra)

# set strings as factors to false
options(stringsAsFactors = FALSE)

#Read in monthly NDVI summary with rainfall attached
interduneNDVI_rain <- read.csv("Data/Monthly_NDVI_Interdune_2000-2018_MOD13Q1_rain.csv", header = TRUE)

interduneNDVI_rain18<-interduneNDVI_rain[interduneNDVI_rain$Year==2018,]
interduneNDVI_rain17<-interduneNDVI_rain[interduneNDVI_rain$Year==2017,]

(ndvi_plot <- interduneNDVI_rain %>%
  ggplot(aes(x = Month, y = NDVI_anomaly),interduneNDVI_rain) +
  geom_point(alpha = .15, size= 4, color = "darkgreen")+
  labs(y = "NDVI Anomaly",
       x = "Month") +
  scale_x_discrete(limits=c("1","2","3","4","5","6","7","8","9","10","11","12"))+
  geom_point(aes(x=Month, y =NDVI_anomaly), size =5, shape=1, interduneNDVI_rain18)+
  geom_point(aes(x=Month, y =NDVI_anomaly), size = 5, interduneNDVI_rain17)+
  geom_line(aes(x=Month, y =NDVI_anomaly), interduneNDVI_rain17)+
  geom_line(aes(x=Month, y =NDVI_anomaly),linetype = "dashed", interduneNDVI_rain18)+
  theme_classic(base_size = 12))

interduneNDVI_rain$Year <- factor(interduneNDVI_rain$Year)

(rain_plot <- interduneNDVI_rain %>%
  ggplot(aes(x = Month, y = AnnSumRain),interduneNDVI_rain) +

  geom_line(data = interduneNDVI_rain, aes(x=Month, y = AnnSumRain, color = Year, ), alpha=0.3, show.legend = FALSE)+
  scale_color_manual(values=c("#000099", "#000099","#000099","#000099","#000099","#000099","#000099","#000099","#000099","#000099","#000099","#000099","#000099","#000099","#000099","#000099","#000099","#000099","#000099"))+
  labs(y = "Rain (mm)",
       x = "Month") +
  scale_x_discrete(limits=c("1","2","3","4","5","6","7","8","9","10","11","12"))+
  geom_point(aes(x=Month, y =AnnSumRain), size =5, shape=1, interduneNDVI_rain18)+
  geom_point(aes(x=Month, y =AnnSumRain), size = 5, interduneNDVI_rain17)+
  geom_line(aes(x=Month, y =AnnSumRain), interduneNDVI_rain17)+
  geom_line(aes(x=Month, y =AnnSumRain),linetype = "dashed", interduneNDVI_rain18)+
    theme_classic(base_size = 12))


figure2<-grid.arrange(rain_plot, ndvi_plot, ncol = 2)
Fig2<-arrangeGrob(rain_plot, ndvi_plot, ncol = 2)
ggsave(file="Figures/Fig2.png", Fig2, width = 8, height = 4, dpi = 600, units = "in", device='png')



