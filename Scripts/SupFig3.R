#Supplementary Fig 3. Scatter plots exploring relationships in vegetation cover change or melon density to hummock size

nara.ag <- read.csv("Data/NaraMultiYear_Data.csv", header=T)

par(mfrow=c(2,2))
plot(nara.ag$Gr17m16.16Green~ nara.ag$TotalHumArea,
     pch=16, 
     xlim=c(0,1250),
     ylim=c(-0.3, 5.5),
     ylab=c('Prop. Increase in Green Area', '2016-2017'),
     xlab='Total Hummock area, m2',
     main = '2017')
abline(h=0, lty=2)
text(Gr17m16.16Green~ TotalHumArea, labels=PlotID,data=nara.ag, cex=0.9,  pos=4, font=2)


plot(nara.ag$Gr18m17.17Green~ nara.ag$TotalHumArea,
     pch=16, 
     xlim=c(0,1250),
     ylim=c(-0.3, 5.5),
     ylab=c('Prop. Increase in Green Area','2017-2018'),
     xlab='Total Hummock area, m2',
     main='2018')
abline(h=0, lty=2)
text(Gr18m17.17Green~ TotalHumArea, labels=PlotID,data=nara.ag, cex=0.9,  pos=4, font=2)


plot(nara.ag$Mature1N17.17Green~ nara.ag$TotalHumArea,
     pch=16, 
     xlim=c(0,1250),
     ylim=c(-0.3, 5.5),
     ylab=c('Melon Density 2017','melons m-2'),
     xlab='Total Hummock area, m2')
    
abline(h=0, lty=2)
text(Mature1N17.17Green~ TotalHumArea, labels=PlotID,data=nara.ag, cex=0.9,  pos=4, font=2)

plot(nara.ag$Mature1N18.18Green~ nara.ag$TotalHumArea,
     pch=16, 
     xlim=c(0,1250),
     ylim=c(-0.3, 5.5),
     ylab=c('Melon Density 2018', 'melons m-2'),
     xlab='Total Hummock area, m2')
    
abline(h=0, lty=2)
text(Mature1N18.18Green~ TotalHumArea, labels=PlotID,data=nara.ag, cex=0.9,  pos=4, font=2)
