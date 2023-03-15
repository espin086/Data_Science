
################################################################
#Importing Songs

setwd("~/Documents/Text Analysis of Quiero Adorar/Quiero-Adorar")
text.v <- scan("Songs.txt", what = "character", sep = "\n")
head(text.v)


################################################################
#Pre-Processing Data

#Removing the line breaks
songs.v <- paste(text.v, collapse = " ")
head(songs.v)

#Making words lower case
songs.lower.v <- tolower(songs.v)
songs.lower.v

#Producing a list of words
song.words.l <- strsplit(songs.lower.v, "\\W")
song.words.l

#Unlisting a word
song.word.v <- unlist(song.words.l)
song.word.v

#Keeping only the non-blanks
not.blanks.v <- which(song.word.v != "")
song.word.v <- song.word.v[not.blanks.v]

#Removing sight words
not.sight.words <- which(song.word.v != "oh" & 
                           song.word.v != "a" & 
                           song.word.v != "tu" &
                           song.word.v != "you" &
                           song.word.v != "to" &
                           song.word.v != "de" &
                           song.word.v != "u" &
                           song.word.v != "que" &
                           song.word.v != "is" &
                           song.word.v != "my" &
                           song.word.v != "your" &
                           song.word.v != "ti" &
                           song.word.v != "we" &
                           song.word.v != "la" &
                           song.word.v != "coro" &
                           song.word.v != "en" &
                           song.word.v != "me" &
                           song.word.v != "mi" &
                           song.word.v != "y" &
                           song.word.v != "on" &
                           song.word.v != "the" &
                           song.word.v != "lo" &
                           song.word.v != "and" &
                           song.word.v != "tú" &
                           song.word.v != "with" &
                           song.word.v != "o" &
                           song.word.v != "verso" &
                           song.word.v != "has" &
                           song.word.v != "s" &
                           song.word.v != "tú" &
                           song.word.v != "with" &
                           song.word.v != "sofi" &
                           song.word.v != "por" &
                           song.word.v != "for" &
                           song.word.v != "of" &
                           song.word.v != "it" &
                           song.word.v != "al" &
                           song.word.v != "un" &
                           song.word.v != "se" &
                           song.word.v != "por" &
                           song.word.v != "for" &
                           song.word.v != "chorus")

song.word.v <- song.word.v[not.sight.words]
head(song.word.v)


################################################################
#Starting Analysis

#Counting the word heart and the calculating a frequency of the word
length(song.word.v[which(song.word.v=="heart")])/length((song.word.v))

#Counting the number of unique words used in the album
length(unique(song.word.v))

#Unique words as a percentage of all words
length(unique(song.word.v))/length(song.word.v)

#Favorite words in songs
song.freq.t <- table(song.word.v)
sorted.song.freq.t <- sort(song.freq.t, decreasing = TRUE)
sorted.song.freq.t

################################################################
#Comparing Word Frequency in the Data

#How gender bias are the songs
sorted.song.freq.t["him"]/sorted.song.freq.t["her"]

#Calculating the relative frequency
sorted.song.rel.freqs.t <- 100*(sorted.song.freq.t/sum(sorted.song.freq.t))

#Top 10 Words
plot(sorted.song.rel.freqs.t[1:20], type = "b", 
     xlab = "Top Twenty Words", ylab = "Percentage of Quiero Adorar", xaxt = "n")
axis(1, 1: 20, labels = names(sorted.song.rel.freqs.t[1:20]))




################################################################
#Token Distribution Analysis

#Creating a sequence the length of the text
n.time.v <- seq(1:length(song.word.v))

#Create a vector for the occurance of 'quiero', standardized for the length of the texrt
quiero.v <- which(song.word.v == 'quiero')
w.count.v <- rep(NA, length(n.time.v))
w.count.v[quiero.v] <- 1

plot(w.count.v, main = "Dispersion Plot of 'quiero' in Quiero Adorar",
     xlab = "Album Time", ylab = "quiero", type = "h", ylim = c(0,1), yaxt = 'n')


#Finding start of new songs
rm(list = ls())
song.v <- scan("Songs.txt", what = "character", sep = "\n")
song.position <- grep("^SONG:", song.v)
song.v[song.position]
