
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

#######################################################
#Start of Measures of Lexical Variety

#Exploring the list object to see what it contains
length(song.raws.l)
names(song.raws.l)
str(song.raws.l)
class(song.raws.l$`SONG: 1: OLOR FRAGANTE `)
song.raws.l[[1]]

#Calculating TTR: type to token ratio for one song
sum(song.raws.l[[1]])/length(song.raws.l[[1]])

#Here is a simple way to do this...
mean(song.raws.l[[1]])

#TTR using lapply to get it for each song
mean.word.use.m <- do.call(rbind, lapply(song.raws.l, mean))

#plotting the word frequency
plot(mean.word.use.m ,type = 'h')

#scaling the songs relative to each other
plot(scale(mean.word.use.m), type = 'h')

#Ordering songs by decreasing order of average word frequency
order(mean.word.use.m, decreasing = TRUE)

#Using the ordering above to order the dataframe
mean.word.use.m[order(mean.word.use.m, decreasing = TRUE),]
