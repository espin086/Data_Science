library(tm)
library(wordcloud)

################################################################
#Importing Songs

setwd("~/Documents/Text Analysis of Quiero Adorar/Quiero-Adorar")
text.v <- readLines("Songs.txt")

# Load the data as a corpus
docs <- Corpus(VectorSource(text.v))

# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))

# Remove numbers
docs <- tm_map(docs, removeNumbers)

# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, removeWords, stopwords("spanish"))

# Remove punctuations
docs <- tm_map(docs, removePunctuation)

# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)


# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("que", "precoro",
                                    "sofi",
                                    "verse",
                                     "bridge",
                                    "ohu",
                                    "oh oh",
                                    "ohohoh",
                                    "uuu",
                                    "julio",
                                    "chorus",
                                    "verso",
                                    "response",
                                    "end",
                                    "verse",
                                    "coro",
                                    "slow",
                                    "oh oh",
                                    "ahh",
                                    "uuu",
                                    "ohu",
                                    "ohoh",
                                    "song",
                                    "pre",
                                    "let",
                                    "ohohoh",
                                    "ohohohohohohohoh",
                                    "cada",
                                    "uuu",
                                    "set",
                                    "peleas",
                                    "lose",
                                    "uuuuu",
                                    "ahh",
                                    "ahhahh",
                                    "mas",
                                    "sostien",
                                    "uuuu",
                                    "dsciende",
                                    "melgar",
                                    "songve",
                                    "though",
                                    "wont",
                                    "uuuu",
                                    "causen",
                                    "falla",
                                    "hacia",
                                    "comes",
                                    "late",
                                    "please",
                                    "sostienresponse",
                                    "talk",
                                    "music"
                                    ))





dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
d

set.seed(18)

#artificially increasing 'quiero' and 'adorar'
d[which(d$word=="quiero"),2] <- 50
d[which(d$word=="adorar"),2] <- 50
d[which(d$word=="comin"),1] <- "coming"
d[which(d$word=="consolad"),1] <- "consolador"

#change "max.words = dim(d)[1]" to get all words in doc
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=dim(d)[1], random.order=FALSE, rot.per=0.35)
