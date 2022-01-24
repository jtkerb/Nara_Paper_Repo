library(tidyr)
library(zoo)
library(ggplot2)
library(dplyr)
library(ggpubr)
library(gridExtra)


dung1<- read.csv("Data/AllDungSummary_Replicate_Yr.csv", header=T)

dung1$Year<-as.factor(dung1$Year)
dung1$DungType<-as.factor(dung1$DungType)
dung1$DungType2 <- factor(dung1$DungType, levels = levels(dung1$DungType)[c(2,1,3,4)])


Fig3a<- ggplot(dung1, aes(x=DungType2, y=Total, fill=Year))+
  geom_boxplot()+
  #coord_cartesian(ylim = c(0,750))+
  scale_fill_manual(values=c("#999999", "#555555")) + 
  theme_classic()+
  theme(legend.position = 'none')

dung2 <- dung1 %>% filter(DungType=='Donkey')

dung2$Combo<-as.factor(dung2$Combo)
dung2$Combo2 <- factor(dung2$Combo, levels = levels(dung2$Combo)[c(3,4,1,2)])

Fig3b <- ggplot(dung2, aes(x=Combo2, y=Total, fill = Year))+
  geom_boxplot()+
  #facet_grid(rows = vars(Year))+
  #scale_y_continuous(trans='log10')+
  #scale_y_sqrt()+
  #coord_cartesian(ylim = c(0, 725))+
  scale_fill_manual(values=c("#999999", "#555555"))+
  theme_classic()+
  theme(legend.position = c(0.8, 0.9))+
  #geom_point(aes(shape=Year), 
  #          position=position_jitterdodge(dodge.width=0.9),
  #          size=2)+
  scale_shape_manual(values=c(5, 17))
  

grid.arrange(Fig3a, Fig3b, ncol = 2)
Fig3<-arrangeGrob(Fig3a, Fig3b, ncol = 2)
ggsave(file="Figures/Fig3_full.png", Fig3, width = 8, height = 4, dpi = 600, units = "in", device='png')

