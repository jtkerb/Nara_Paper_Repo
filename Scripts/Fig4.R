#This code will generate the zoomed in panels used in Figure 4 that are combined with full axes plots to create the final figure (w y axis breaks)

library(ggplot2)
library(gridExtra)

#Basis for Figure 4 
nara.ag <- read.csv("Data/NaraMultiYear_Data.csv", header=T)

#Arrange Experiment combination factors for better plotting
nara.ag$Combo<-as.factor(nara.ag$Combo)
nara.ag$Combo2 <- factor(nara.ag$Combo, levels = levels(nara.ag$Combo)[c(3,4,1,2)])

#Figure 4
Green17<-ggplot(nara.ag, aes(x=Combo2, y=Gr17m16.16Green, fill = Treatment, color = Location)) + 
  geom_boxplot()+
  coord_cartesian(ylim=c(-0.5, 3.25))+
  scale_fill_manual(values=c("#555555", "#999999")) +
  scale_color_manual(values = c("#333333", "#333333"))+
  guides(color='none')+
  ylab("Proportional change in vegetative cover")+
  labs(x=NULL)+
  stat_summary(fun=mean, geom="point", shape=18, size=4, color="black", fill="black")+
  theme(legend.position = "none") + 
  theme(panel.background = element_rect(fill = "#CCCCCC", color = "white", size = 0.5, linetype = "solid"))


Green18<-ggplot(nara.ag, aes(x=Combo2, y=Gr18m17.17Green, fill = Treatment, color = Location)) + 
  geom_boxplot()+
  coord_cartesian(ylim=c(-0.5, 3.25))+
  #coord_cartesian(ylim=c(1.5, 5.25))+  ### note: the commented out graphical parameters here are used in the replotting needed for the axis breaks.
  scale_y_continuous(breaks=seq(1,6, 1))+
  scale_fill_manual(values=c("#666666", "#999999")) +
  scale_color_manual(values = c("#333333", "#333333"))+
  ylab("")+
  labs(x=NULL)+
  labs(y=NULL)+
  stat_summary(fun=mean, geom="point", shape=18, size=4, color="black", fill="black")+
  theme(legend.position = "none")+ 
  theme(panel.background = element_rect(fill = "#CCCCCC", color = "white", size = 0.5, linetype = "solid"))


Fruit17<-ggplot(nara.ag, aes(x=Combo2, y=Mature1N17.17Green, fill = Treatment, color = Location)) + 
  geom_boxplot()+
  coord_cartesian(ylim=c(-0.5, 3.25))+
  scale_fill_manual(values=c("#666666", "#CCCCCC")) +
  scale_color_manual(values = c("#333333", "#333333"))+
  ylab(expression(paste("Density of mature melons ", m^-2)))+
  theme(legend.position = "none")+ 
  theme(panel.background = element_rect(fill = "#FFFFFF", color = "black", size = 0.5, linetype = "solid"),
        panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                        color = "LightGray"), 
        panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                        color = "LightGray"))+
  stat_summary(fun=mean, geom="point", shape=18, size=4, color="black", fill="black")+
  xlab("2016-2017")

Fruit18<-ggplot(nara.ag, aes(x=Combo2, y=Mature1N18.18Green, fill = Treatment, color = Location)) + 
  geom_boxplot()+
  coord_cartesian(ylim=c(-0.5, 3.25))+
  #coord_cartesian(ylim=c(0.75, 4.5))+  ### note: the commented out graphical parameters here are used in the replotting needed for the axis breaks.
  #scale_y_continuous(breaks=seq(1.5,4.5, 1))+
  scale_y_continuous(breaks=seq(1,6, 1))+
  scale_fill_manual(values=c("#666666", "#CCCCCC")) +
  scale_color_manual(values = c("#333333", "#333333"))+
  labs(y=NULL)+
  theme(legend.position = "none")+ 
  theme(panel.background = element_rect(fill = "#FFFFFF", color = "black", size = 0.5, linetype = "solid"),
        panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                        color = "#CCCCCC"), 
        panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                        color = "#CCCCCC"))+
  stat_summary(fun=mean, geom="point", shape=18, size=4, color="black", fill="black")+
  xlab("2017-2018")

grid.arrange(Green17, Green18,Fruit17,Fruit18, nrow = 2)

fourpanel<-arrangeGrob(Green17, Green18,Fruit17,Fruit18, nrow = 2)
ggsave(file="Figures/Fig4_zoom2.png", fourpanel, width = 8, height = 8, dpi = 600, units = "in", device='png')
