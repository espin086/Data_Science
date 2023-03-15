#############################################################
#Importing and cleaning the data.
library(caret)

set.seed(1981)

setwd("C:/Users/ESPIJ090.WDW/datasciencecoursera - data/")
#Creates a folder for data if there isn't one already.
if (!file.exists("data")) {
        dir.create("data")
}

#Downloading Training Data.
fileUrl <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
download.file(fileUrl, destfile = "./data/nonvalidation.csv")
nonvalidation <- read.csv("./data/nonvalidation.csv")


nonvalidation <- nonvalidation[,union(grep("^accel_", colnames(nonvalidation)),grep("classe",colnames(nonvalidation)) )]


#Removing Near Zero Variance variables.
nzv <- nearZeroVar(nonvalidation, saveMetrics= TRUE)
nzv<-nzv[nzv$nzv=="TRUE",]
nzv<-row.names(nzv)
myvars <- names(nonvalidation) %in% nzv
nonvalidation <- nonvalidation[!myvars]


#############################################################
#Training the Model

#Creating a training, testing, and validation dataset.

# Create a building data set and validation set
inBuild <- createDataPartition(y=nonvalidation$classe,p=0.7, list=FALSE)
validation <- nonvalidation[-inBuild,]
buildData <- nonvalidation[inBuild,]

inTrain <- createDataPartition(y=buildData$classe,p=0.7, list=FALSE)
training <- buildData[inTrain,]
testing <- buildData[-inTrain,]

#Training Multiple Models
fit.rt <- train(classe ~.,method="rpart",data=training) 
pred.rt <- predict(fit.rt,testing)
confusionMatrix(testing$classe, pred.rt)

fit.lda <- train(classe ~.,method="lda",data=training)
pred.lda <- predict(fit.lda,testing)
confusionMatrix(testing$classe, pred.lda)

fit.knn <- train(classe ~.,method="knn",data=training)
pred.knn <- predict(fit.knn,testing)
confusionMatrix(testing$classe, pred.knn)

fit.nnet <- train(classe ~.,method="nnet",data=training)
pred.nnet <- predict(fit.nnet,testing)
confusionMatrix(testing$classe, pred.nnet)


#Combine Predictors to create a new model.
predDF <- data.frame(pred.rt ,pred.lda,pred.knn,pred.nnet,classe=testing$classe)
combModFit <- train(classe ~.,method="rf",data=predDF)

#Prediction on validation set for final assessment.
pred.rf.v <- predict(fit.rt,validation)
pred.lda.v <- predict(fit.lda,validation)
pred.knn.v <- predict(fit.knn,validation)
pred.nnet.v <- predict(fit.nnet,validation)

predVDF <- data.frame(pred.rt=pred.rf.v,pred.lda=pred.lda.v,pred.knn=pred.knn.v,pred.nnet=pred.nnet.v)
combPredV <- predict(combModFit,predVDF)


confusionMatrix(validation$classe, pred.rf.v)
confusionMatrix(validation$classe, pred.lda.v)
confusionMatrix(validation$classe, pred.knn.v)
confusionMatrix(validation$classe, pred.nnet.v)
confusionMatrix(validation$classe, combPredV)



#Predicting on submission dataset.
fileUrl <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
download.file(fileUrl, destfile = "./data/submission.csv")
submission <- read.csv("./data/submission.csv")

pred.rf.s <- predict(fit.rt,submission)
pred.lda.s <- predict(fit.lda,submission)
pred.knn.s <- predict(fit.knn,submission)
pred.nnet.s <- predict(fit.nnet,submission)


predSDF <- data.frame(pred.rt=pred.rf.s,pred.lda=pred.lda.s,pred.knn=pred.knn.s,pred.nnet=pred.nnet.s)

combPredS <- predict(combModFit,predSDF)

answers <- as.character(combPredS)

pml_write_files = function(x){
        n = length(x)
        for(i in 1:n){
                filename = paste0("problem_id_",i,".txt")
                write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
        }
}


pml_write_files(answers)



