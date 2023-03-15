setwd("~/Documents/Text Classifiction - 2016 Presidential Position on Issues/1. Data/2. Trump")

text.v <- scan("RNC Speech.txt", what = "character", sep = "\n")

######################
#Cleaning Trump RNC Speech

#lowercase words to avoid double counting
text.lower.v <- tolower(text.v)

#separating out words in text
text.words.l <-strsplit(text.lower.v, "\\W")

#unlisting words
text.words.v <- unlist(text.words.l)

#Removing blanks
not.blanks.v <- which(text.words.v !="")
text.words.v <- text.words.v[not.blanks.v]


######################
#Simple Text Frequency Analysis

#Frequency of specific word
hits <- length(text.words.v[which(text.words.v == "muslim")])
total.words <- length(text.words.v)
hits / total.words

#Frequency of all words
text.freqs.t <- table(text.words.v)
sorted.text.freqs.t <- sort(text.freqs.t, decreasing = TRUE)

#Plot of top 10 words by %
sorted.text.rel.freqs.t <- 100*(sorted.text.freqs.t/sum(sorted.text.freqs.t))

plot(sorted.text.rel.freqs.t[1:10], type = "b", col = "red",
     xlab = "Top Ten Words", ylab = "Total Word Count", 
     xaxt = "n")
axis(1, 1:10, labels = names(sorted.text.rel.freqs.t[1:10]))


######################
#Text Distribution Analysis
n.time.v <- seq(1:length(text.words.v)) #creating lenght of text
word.v <- which(text.words.v=="america") #counting word
w.count.v <- rep(NA, length(n.time.v)) #empty vector of NA
w.count.v[word.v] <- 1 #replacing empties with 1 where word is found in text

plot(w.count.v, main = "Dispersion of Plot of 'america' in Trump RNC Speech", 
     xlab = "Speech Time", ylab = 'america', type = 'h', ylim = c(0,1), yaxt = 'n')

######################
#Measuring Lexical variety

#mean word frequecy or the average number of times a word is used
mean(sorted.text.freqs.t)

#hapax richness calculates - or the count of unique words
hapax <- sapply(sorted.text.freqs.t, function(x) sum(x ==1))
hapax.percentage <- sum(hapax)/sum(sorted.text.freqs.t)
hapax.percentage
