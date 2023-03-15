################################################################

#Importing data from Github

library(RCurl)
library(foreign)
library(linprog)

url <- "https://docs.google.com/spreadsheets/d/1PnApS78YiDPaMnRpkZM2Z19tBIJSVkR6XfWrtACGAl4/pub?output=csv"
room.mates <- getURL(url)                
room.mates <- read.csv(textConnection(room.mates), header = TRUE, skip =0)

url2 <- "https://docs.google.com/spreadsheets/d/1Kg7ceTcX6C8MLYHuWkDSFJWgvKqI_b5bJpP-6Zbj9aM/pub?output=csv"
chores <- getURL(url2)                
chores <- read.csv(textConnection(chores), header = TRUE, skip =0)

################################################################

#Calculating how good person 1 is at each chore.

p1.c1 <- sum(room.mates[1,2:4] - chores[1,2:4])
p1.c2 <- sum(room.mates[1,2:4] - chores[2,2:4])
p1.c3 <- sum(room.mates[1,2:4] - chores[3,2:4])

p1 <- rbind(c(p1.c1, p1.c2, p1.c3))

#Calculating how good person 2 is at each chore.

p2.c1 <- sum(room.mates[2,2:4] - chores[1,2:4])
p2.c2 <- sum(room.mates[2,2:4] - chores[2,2:4])
p2.c3 <- sum(room.mates[2,2:4] - chores[3,2:4])

p2 <- rbind(c(p2.c1, p2.c2, p2.c3))


#Calculating how good person 3 is at each chore.

p3.c1 <- sum(room.mates[3,2:4] - chores[1,2:4])
p3.c2 <- sum(room.mates[3,2:4] - chores[2,2:4])
p3.c3 <- sum(room.mates[3,2:4] - chores[3,2:4])

p3 <- rbind(c(p3.c1, p3.c2, p3.c3))


#Combining person-chore 'cost' matrix
final <- rbind(p1, p2, p3)

################################################################

#Solving the Assignment Problem
answer <- lp.assign(final, direction = "min")
answer$solution
answer$objval



