# Machine Learning Project
##Predicting the Quality of Weight Lifting Exercises

This document contains the following details about the the analysis contained in the ModelFitting R code in this repository.

##Instructions

Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement – a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. In this project, your goal will be to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. They were asked to perform barbell lifts correctly and incorrectly in 5 different ways. More information is available from the website here: http://groupware.les.inf.puc-rio.br/har (see the section on the Weight Lifting Exercise Dataset). 

The goal of your project is to predict the manner in which they did the exercise. This is the "classe" variable in the training set. You may use any of the other variables to predict with. You should create a report describing how you built your model, how you used cross validation, what you think the expected out of sample error is, and why you made the choices you did. You will also use your prediction model to predict 20 different test cases. 

##Data

The training data for this project are available here: 

https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv

The test data are available here: 

https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv

The data for this project come from this source: http://groupware.les.inf.puc-rio.br/har. If you use the document you create for this class for any purpose please cite them as they have been very generous in allowing their data to be used for this kind of assignment. 

The data were processed in the following manner:
- only the acceleration variables were used
- removed any near zero variance variables
- downloaded the training data set and partitioned it into training (70%), testing (20%), and validation (10%)
- kept the test dataset in the link above as to run the model only once to get my estimate of the out-of-sample training error

##Algorithms

The following algorithms were used to builed an ensemble machine learning algorithm, meaning each of the algorithms predictions were then used as predictors themselves and cross-validated against the testing data to build the final model:

Ensemble Model with the following models outputs used as inputs into the broader Ensemble Model
- Random Forest
- Linear Discriminant Analysis
- K-nearest neighbors
- Neural Networks

The ensemble model took the outputs from the model above and fit those outputs to the data using a random forest model. Each individual model was tuned-on the training data, with the ensemble model being trained on the testing data.  The final evaluation was of the Ensemble model on the validation data.

##Output & Expected Out-of-Sample Error

The out-of-sample errors accuracy are shown below for each of the models, plus the out-of-sample error is shown for the ensemble model which is the final prediction for the out-of-sample error.

###Ensemble Model - 83% 
####Random Forest - 43% 
####Linear Discriminant Analysis - 52%
####K-nearest neighbors - 82%
####Neural Networks - 41%

