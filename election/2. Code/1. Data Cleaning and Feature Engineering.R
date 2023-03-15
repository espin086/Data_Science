#WARNING: Convert all data into text and ensure ANSI encoding can use this site to convert:  http://utils.paranoiaworks.org/diacriticsremover/
#PDF to text site
#http://pdftotext.com/


#init
libs<- c("tm", "plyr", "class", "reshape")
lapply(libs, require, character.only = TRUE)


#set options
options(stringsAsFactors = FALSE)

#set parameters
#1. Not Contacted, 2. Phone Screened, 3. In Person Interview
#0. Test 1, 0. Test 2
candidates <- c("1. Hilary", "2. Trump") 
pathname <- "/Users/jjespinoza/Documents/Text Classifiction - 2016 Presidential Position on Issues/1. Data"


#Clean text
cleanCorpus <- function(corpus){
        corpus.tmp <- tm_map(corpus, removePunctuation)
        corpus.tmp <- tm_map(corpus.tmp, stripWhitespace)
        #corpus.tmp <- tm_map(corpus.tmp, tolower)
        corpus.tmp <- tm_map(corpus.tmp, content_transformer(tolower))
        corpus.tmp <- tm_map(corpus.tmp, removeWords, stopwords("english"))
        return(corpus.tmp)
}

#Build a Term-Document-Matrix(TDM)
generateTDM <- function(cand, path){
        s.dir <- sprintf("%s/%s", path, cand)
        #s.cor <- Corpus(DirSource(directory = s.dir, encoding = "ANSI"))
        s.cor <- VCorpus(DirSource(directory = s.dir), readerControl = list(reader=readPlain))
        s.cor.cl <- cleanCorpus(s.cor)
        s.tdm <- TermDocumentMatrix(s.cor.cl)
        s.tdm <- removeSparseTerms(s.tdm, 0.40)
        result <- list(name = cand, tdm = s.tdm)
}

tdm <- lapply(candidates, generateTDM, path = pathname)

#attach interview result to matrix
bindCandidateToTDM <- function(tdm){
        s.mat <- t(data.matrix(tdm[["tdm"]]))
        s.df <- as.data.frame(s.mat, stringsAsFactors = FALSE)
        s.df <- cbind(rep(tdm[["name"]], nrow(s.df)), s.df)
        #colnames(s.df)[ncol(s.df)] <- "interviewresult"
}

candTDM <- lapply(tdm, bindCandidateToTDM)


#stack
tdm.stack <- do.call(rbind.fill, candTDM)
tdm.stack[is.na(tdm.stack)] <- 0

#Renaming target variable 
colnames(tdm.stack)[1] <- "target"

#Removing fields with near-zero-variance
#Removing Near Zero Variance variables.
nzv <- nearZeroVar(tdm.stack, saveMetrics= TRUE)
nzv<-nzv[nzv$nzv=="TRUE",]
nzv<-row.names(nzv)
myvars <- names(tdm.stack) %in% nzv
tdm.stack <- tdm.stack[!myvars]



#Exporting Clean Dataset
setwd(pathname)

write.csv(tdm.stack, "TDM.csv", row.names = FALSE)




