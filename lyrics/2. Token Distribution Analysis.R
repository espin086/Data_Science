
################################################################
#Importing Songs

setwd("~/Documents/Text Analysis of Quiero Adorar/Quiero-Adorar")

#Finding start of new songs
rm(list = ls())
song.v <- scan("Songs.txt", what = "character", sep = "\n")
song.position <- grep("^SONG:", song.v)
song.v[song.position]

#Adding a new line to songs to identify the end of the document.
song.v <- c(song.v, "END")
last.position <- length(song.v)
song.position <- c(song.position, last.position)


#Creating two lists to store results or raw frequencies and relative frequencies
song.raws.l <- list()
song.freqs.l <- list()

for(i in 1:length(song.position)){#initiates a for loop that iterates over song position
  if (i != length(song.position)){#Stopping loop at end of document
          
          #Preparing the Data
          song.title <- song.v[song.position[i]] #Capturing the song title
          start <- song.position[i] + 1 #Adding 1 to position to get first line of song
          end <- song.position[i + 1] - 1#Getting last line of a song
          
          #Similar to analysis done in first analysis 1. First Initial...
          song.lines.v <- song.v[start:end]
          song.words.v <- tolower(paste(song.lines.v, collapse = " "))
          song.words.l <- strsplit(song.words.v, "\\W")
          song.words.v <- unlist(song.words.l)
          song.words.v <- song.words.v[which(song.words.v != "")]
          
          #Removing commong sight words
          #Removing sight words
          not.sight.words <- which(song.words.v != "oh" & 
                                           song.words.v != "a" & 
                                           song.words.v != "tu" &
                                           song.words.v != "you" &
                                           song.words.v != "to" &
                                           song.words.v != "de" &
                                           song.words.v != "u" &
                                           song.words.v != "que" &
                                           song.words.v != "is" &
                                           song.words.v != "my" &
                                           song.words.v != "your" &
                                           song.words.v != "ti" &
                                           song.words.v != "we" &
                                           song.words.v != "la" &
                                           song.words.v != "coro" &
                                           song.words.v != "en" &
                                           song.words.v != "me" &
                                           song.words.v != "mi" &
                                           song.words.v != "y" &
                                           song.words.v != "on" &
                                           song.words.v != "the" &
                                           song.words.v != "lo" &
                                           song.words.v != "and" &
                                           song.words.v != "tú" &
                                           song.words.v != "with" &
                                           song.words.v != "o" &
                                           song.words.v != "verso" &
                                           song.words.v != "has" &
                                           song.words.v != "s" &
                                           song.words.v != "tú" &
                                           song.words.v != "with" &
                                           song.words.v != "sofi" &
                                           song.words.v != "por" &
                                           song.words.v != "for" &
                                           song.words.v != "of" &
                                           song.words.v != "it" &
                                           song.words.v != "al" &
                                           song.words.v != "un" &
                                           song.words.v != "se" &
                                           song.words.v != "por" &
                                           song.words.v != "for" &
                                           song.words.v != "chorus")
          
          song.words.v <- song.words.v[not.sight.words]
          
          
          #Creating Frequency Tables
          song.freqs.t <- table(song.words.v)
          song.raws.l[[song.title]] <- song.freqs.t
          song.freqs.t.rel <- 100*(song.freqs.t/sum(song.freqs.t))
          song.freqs.l[[song.title]] <- song.freqs.t.rel
  
  }
}

###################################################
#Begining of listwise analysis

#Applying the subset function to the relative frequency of a word in each song
quiero.l <- lapply(song.freqs.l, '[', 'quiero')
adorar.l <- lapply(song.freqs.l, '[', 'adorar')

#Rbinding all the list to get a matrix with all the data
quiero.m <- do.call(rbind,quiero.l)
adorar.m <- do.call(rbind,adorar.l)

#Pulling frequency vectors out to combine two frequencies
quiero.v <- quiero.m[,1]
adorar.v <- adorar.m[,1]
quiero.adorar.m <- cbind(quiero.v, adorar.v)

#Renaming columns above
colnames(quiero.adorar.m) <- c("quiero", "adorar")

#Creating a barplot of the two words
barplot(quiero.adorar.m, beside = TRUE, col = 'red')

#############################################
#Correlation Analysis

#setting NAs equal to blanks
the.na.positions <- which(is.na(quiero.adorar.m))
#set the values of NA to zero in the matrix
quiero.adorar.m[the.na.positions] <- 0

#running the correlation analysis
cor(quiero.adorar.m)

#converting to a dataframe for testing purposes and ease of use
cor.data.df <- as.data.frame(quiero.adorar.m)
cor(cor.data.df)

#Single randomized correlation
cor(sample(cor.data.df$quiero), cor.data.df$adorar)


#the following code is used to demonstrate how common the correlation we observed would happen by chance
mycors.v <- NULL
for (i in 1:10000){
        mycors.v <- c(mycors.v, cor(sample(cor.data.df$quiero), cor.data.df$adorar))
}

#Plotting the distribution
h <- hist(mycors.v, breaks = 100, col='red',
     xlab="Correlation Coefficient", 
     main = "Histogram of Random Correlation Coefificien\n
     with Normal Curve", 
     plot=TRUE)

xfit <- seq(min(mycors.v), max(mycors.v), length = 1000)
yfit <- dnorm(xfit, mean =mean(mycors.v), sd = sd(mycors.v))
yfit <- yfit*diff(h$mids[1:2])*length(mycors.v)
lines(xfit, yfit, col = "black", lwd=2)

