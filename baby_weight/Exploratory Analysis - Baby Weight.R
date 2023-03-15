#Set working directory
setwd("~/Documents/data-dad/Baby Weight")

bwght2 <- read.csv("bwght2.csv")

names(bwght2) <- c("mage","meduc", "monpre", "npvis", "fage", "feduc", "bwght", 
                   "omaps", "fmaps", "cigs","drink","lbw","vlbw","male","mwhte", 
                   "mblck", "moth", "fwhte", "fblck", "foth", "lbwght", "magesq",
                   "npvissq")         


#mage               mother's age, years
#meduc              mother's educ, years
#monpre             month prenatal care began
#npvis              total number of prenatal visits
#fage               father's age, years
#feduc              father's educ, years
#bwght              birth weight, grams
#omaps              one minute apgar score
#fmaps              five minute apgar score
#cigs               avg cigarettes per day
#drink              avg drinks per week
#lbw                =1 if bwght <= 2000
#vlbw               =1 if bwght <= 1500
#male               =1 if baby male
#mwhte              =1 if mother white
#mblck              =1 if mother black
#moth               =1 if mother is other
#fwhte              =1 if father white
#fblck              =1 if father black
#foth               =1 if father is other
#lbwght            log(bwght)
#magesq            mage^2
#npvissq           npvis^2

str(bwght2)
summary(bwght2)
head(bwght2)
tail(bwght2)

#What is are the number of prenatal visits that maximize birthweight?
lm.1 <- lm(bwght ~ npvis + npvissq, data = bwght2)
summary(lm.1)
plot(bwght2$npvis, bwght2$bwght, col="red", pch = 20, 
     xlab = "Prenatal Visits",
     ylab = "Birth Weight in Grams",
     main = "Relationship between doctor visits and baby weight")
abline(lm.1, col="blue")


#Controlling for pre-natal visits what is the optimum age for birthweight
lm.2 <- lm(bwght ~ npvis + npvissq + mage + magesq, data = bwght2)
summary(lm.2)
plot(bwght2$mage, bwght2$bwght, col="red", pch = 20, 
     xlab = "Mother's Age",
     ylab = "Birth Weight in Grams",
     main = "Relationship between mother's age and baby weight")
abline(lm.2, col="blue")

#Actual distribution of prenatal visits and mother's age
hist(bwght2$npvis, col = "red", xlab = "Prenatal Visits", 
     main = "Histogram of Prenatal Visits")
summary(bwght2$npvis)

hist(bwght2$mage, col = "red", xlab = "Mother's Age", 
     main = "Histogram of Mother's Age")
summary(bwght2$mage)




