library(ggplot2)
library(scales)

fruit<-read.csv('Data/FruitForChart.csv')
summary(fruit)


fruit$Dates<-as.POSIXct(fruit$Date, format="%d/%m/%y")
class(fruit$Dates)
p1 <- ggplot(data= fruit, aes(x=Dates, y=Mature1)) +
  geom_bar(stat='identity')+
  scale_x_datetime(date_labels = "%b-%Y", breaks = date_breaks("1 month"))+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 90))+
  ylab('Nara Melons')+
  xlab('Month and Year')

p1
