## Two-way ANOVA analyses for Kerby et al. 2022
rm(list = ls())
library(tidyverse)
library(ggplot2)
library(ggpubr)
library(broom)
library(rstatix)
library(emmeans)
library(multcompView)
library(multcomp)


NaraData <- read.csv("Data/NaraMultiYear_Data.csv")
#############################################################################################################
## 1. Changes in green cover#################################################################################
#############################################################################################################
NaraData %>% group_by(Combo) %>% 
  summarise(mean(Gr17m16.16Green))

NaraData %>% group_by(Combo) %>% 
  summarise(mean(Gr18m17.17Green))

## 2016-2017################################################################################################
ggboxplot(NaraData, x="Location", y="Gr17m16.16Green", color="Treatment")
green17m16 <- aov(Gr17m16.16Green~Treatment*Location, data=NaraData)
GreenYear1 <- tidy(anova(green17m16))
GreenYear1

#Evaluating Assumptions
ggqqplot(residuals(green17m16)) #The residuals appear normally distributed
shapiro_test(residuals(green17m16)) #Non significant p-value, so we assume normality

NaraData %>% #The response variable was normally distributed for each pairing (p >0.05), assessed by Shapiro-Wilkes test of normality
  group_by(Treatment, Location) %>%
  shapiro_test(Gr17m16.16Green)

ggqqplot(NaraData, "Gr17m16.16Green", ggtheme = theme_bw()) + #The residuals appear normally distributed
  facet_grid(Treatment ~ Location)

NaraData %>% levene_test(Gr17m16.16Green ~ Treatment*Location) # Levene's test not significant (p > 0.05), so assume homogeneity of variances.

## (post hoc test to explore interaction)
leastsquare <- emmeans(green17m16, 
                       pairwise ~ Treatment:Location)
comparisons <- pairs(leastsquare)
comparisons$emmeans ## Gives 6 direct comparisons of the 4 groups, using Tukey p value adjustment

#With green area as covariate (separate ANOVAs) - not a useful predictor
green17m16_Tr_size17 <- aov(Gr17m16.16Green~Treatment*GreenArea17, data=NaraData)
GreenYear1_Tr_Size17 <- tidy(anova(green17m16_Tr_size17))
GreenYear1_Tr_Size17

green17m16_Lo_size17 <- aov(Gr17m16.16Green~Location*GreenArea17, data=NaraData)
GreenYear1_Lo_Size17 <- tidy(anova(green17m16_Lo_size17))
GreenYear1_Lo_Size17


## 2017-2018 ##############################################################################################
ggboxplot(NaraData, x="Location", y="Gr18m17.17Green", color="Treatment")
green18m17 <- aov(Gr18m17.17Green~Treatment*Location, data=NaraData)
GreenYear2 <- tidy(anova(green18m17))
GreenYear2

#Evaluating Assumptions
ggqqplot(residuals(green18m17)) #The residuals appear normally distributed APART from one outlier

#We evaluate how this outlier influenced the conclusions by removing it, especially the chance of a Type I error.
NaraData_no_outlier <- subset(NaraData, PlotID!= '10E')

ggboxplot(NaraData_no_outlier, x="Location", y="Gr18m17.17Green", color="Treatment")
green18m17_noOutlier <- aov(Gr18m17.17Green~Treatment*Location, data=NaraData_no_outlier)

GreenYear2_noOutlier <- tidy(anova(green18m17_noOutlier))
GreenYear2_noOutlier #The conclusions remain the same as the original test.

#for unbalanced design introduced by outlier
#The conclusions remain the same as the original test
Anova(lm(Gr18m17.17Green~Treatment*Location,
         contrasts=list(Treatment='contr.sum', Location ='contr.sum'),
         data = NaraData_no_outlier),
      type='III')

ggqqplot(residuals(green18m17_noOutlier)) #The residuals appear normally distributed after the outlier removed
shapiro_test(residuals(green18m17_noOutlier)) #No significant p-values (p>0), so we assume normality after the outlier removed

NaraData_no_outlier %>% #The response variable was normally distributed for each pairing (p >0.05), assessed by Shapiro-Wilkes test of normality
  group_by(Treatment, Location) %>%
  shapiro_test(Gr18m17.17Green)

ggqqplot(NaraData_no_outlier, "Gr18m17.17Green", ggtheme = theme_bw()) + #The residuals appear normally distributed
  facet_grid(Treatment ~ Location)

NaraData_no_outlier %>% levene_test(Gr18m17.17Green ~ Treatment*Location) # Levene's test not significant (p > 0.05), so assume homogeneity of variances.


#With green area as covariate (separate ANOVAs) - not a useful predictor
green18m17_Tr_size18 <- aov(Gr18m17.17Green~Treatment*GreenArea18, data=NaraData)
GreenYear2_Tr_Size18 <- tidy(anova(green18m17_Tr_size18))
GreenYear2_Tr_Size18

green18m17_Lo_size18 <- aov(Gr18m17.17Green~Location*GreenArea18, data=NaraData)
GreenYear2_Lo_Size18 <- tidy(anova(green18m17_Lo_size18))
GreenYear2_Lo_Size18


## 2. Melons ###################################################################################################
## 2016-2017 ##############################################################################################
ggboxplot(NaraData, x="Location", y="Mature1N17.17Green", color="Treatment")

fruit17 <- aov(Mature1N17.17Green~Treatment*Location, data=NaraData)
FruitYear1 <- tidy(anova(fruit17))
FruitYear1


#Evaluating Assumptions
ggqqplot(residuals(fruit17)) #The residuals appear normally distributed
shapiro_test(residuals(fruit17)) #Non significant p-value, so we assume normality

NaraData %>% #The response variable was normally distributed for each pairing (p >0.05) EXCEPT near controls, assessed by Shapiro-Wilkes test of normality
  group_by(Treatment, Location) %>% #This appears to be the result of there being very few/no melons observed.
  shapiro_test(Mature1N17.17Green)


ggqqplot(NaraData, "Mature1N17.17Green", ggtheme = theme_bw()) + #The residuals appear normally distributed
  facet_grid(Treatment ~ Location)

NaraData %>% levene_test(Gr17m16.16Green ~ Treatment*Location) # Levene's test not significant (p > 0.05), so assume homogeneity of variances.

#With green area as covariate (separate ANOVAs) - not a useful predictor
fruit17_tr_size <- aov(Mature1N17.17Green~Treatment*GreenArea17, data=NaraData)
FruitYear2_Tr_Size17 <- tidy(anova(fruit17_tr_size))
FruitYear2_Tr_Size17

fruit17_lo_size <- aov(Mature1N17.17Green~Location*GreenArea17, data=NaraData)
FruitYear2_Lo_Size17 <- tidy(anova(fruit17_lo_size))
FruitYear2_Lo_Size17

## 2017-2018 ##############################################################################################
ggboxplot(NaraData, x="Location", y="Mature1N18.18Green", color="Treatment")

fruit18 <- aov(Mature1N18.18Green~Treatment*Location, data=NaraData)
FruitYear2 <- tidy(anova(fruit18))
FruitYear2

#Evaluating Assumptions
ggqqplot(residuals(fruit18)) #The residuals do NOT appear normally distributed
shapiro_test(residuals(fruit18)) #Significant p-value, so we cannot assume normality


NaraData %>% #The response variable was normally distributed for each pairing (p >0.05) EXCEPT near controls, assessed by Shapiro-Wilkes test of normality
  group_by(Treatment, Location) %>% #This appears to be the result of there being very few/no melons observed.
  shapiro_test(Mature1N17.17Green)


ggqqplot(NaraData, "Mature1N17.17Green", ggtheme = theme_bw()) + #The residuals appear normally distributed
  facet_grid(Treatment ~ Location)

NaraData %>% levene_test(Gr17m16.16Green ~ Treatment*Location) # Levene's test not significant (p > 0.05), so assume homogeneity of variances.


#With green area as covariate (separate ANOVAs) - not a useful predictor
fruit18_tr_size <- aov(Mature1N18.18Green~Treatment*GreenArea18, data=NaraData)
FruitYear2_Tr_Size18 <- tidy(anova(fruit18_tr_size))
FruitYear2_Tr_Size18

fruit18_lo_size <- aov(Mature1N18.18Green~Location*GreenArea18, data=NaraData)
FruitYear2_Lo_Size18 <- tidy(anova(fruit18_lo_size))
FruitYear2_Lo_Size18


###########################################################################################################################
## Save and export results
sink('NaraTwoWayANOVAResultsFINAL.csv')

cat('Green Year 1')
write.csv(GreenYear1)

cat('Green Year 2')
write.csv(GreenYear2)

cat('Fruit Year 1')
write.csv(FruitYear1)

cat('Fruit Year 2')
write.csv(FruitYear2)

sink()

## Visualize ANOVA results
combinedANOVAs <- read.csv("NaraTwoWayANOVAResultsFINAL.csv")

