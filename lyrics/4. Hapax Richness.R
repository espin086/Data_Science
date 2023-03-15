
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

##################################
#Hapax analysis

#Counting words that only appear once a.k.a Hapax per song
song.hapax.v <- sapply(song.raws.l, function(x) sum(x == 1))

#length per song
song.length <- do.call(rbind,lapply(song.raws.l, sum))

#Calculating hapax percentages
hapax.percentages <- song.hapax.v/song.length
barplot(hapax.percentages, beside = T, col = 'red', names.arg = seq(1:length(song.raws.l)))

