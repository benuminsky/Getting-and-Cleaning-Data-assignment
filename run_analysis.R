## STEP 1: Combine multiple data sets into a single data set to tidy up


## First I am reading "features.txt" to get a data frame
## of 561 variables and assigning it to "features". Ultimately we only
## care about collumn V2
features<-read.table("./data/UCIdata/features.txt",header=F)

## Read in the X_Train, Subject_Train, and Y_Train data using read.table()
## Also name all 563 variables using the variables from "features" and add in
## the "subject" and "activity" variable names
## Collumn bind all three data sets together
Xtrain<-read.table("./data/UCIdata/train/X_train.txt", header=F)
colnames(Xtrain)<-features$V2
subjecttrain<-read.table("./data/UCIdata/train/subject_train.txt", header=F)
Ytrain<-read.table("./data/UCIdata/train/Y_train.txt", header=F)
sytrain<-data.frame(subjecttrain,Ytrain)
colnames(sytrain)<-c("subject","activity")
train<-data.frame(sytrain,Xtrain)


## Read in the X_Test, Subject_Test, and Y_Test data using read.table(). 
## Also name all 563 variables using the variables from "features" and add in
## the "subject" and "activity" variable names
## Collumn bind all three data sets together
Xtest<-read.table("./data/UCIdata/test/X_test.txt", header=F)
colnames(Xtest)<-features$V2
subjecttest<-read.table("./data/UCIdata/test/subject_test.txt", header=F)
Ytest<-read.table("./data/UCIdata/test/Y_test.txt", header=F)
sytest<-data.frame(subjecttest,Ytest)
colnames(sytest)<-c("subject","activity")
test<-data.frame(sytest,Xtest)


## Combine the two data sets of "train" and "test" using the rbind() to make 
## a final tidy data set
cooldata<-rbind(train,test)

## STEP 2: Extract out only the data that is related to the mean or standard 
## deviation, including the "subject" and "activity" columns as well, and 
## create a new data set

## Use the grep function to pull out all columns that have the string "mean"
## anywhere in header name. You will wind up with 79 columns. grep() is able 
## to locate 46 column headers with the string "mean" and 33 column headers
## with the string "std". Add in your columns for "subject" and "activity"
## and you have 81 total varibales in your new data set.
cooldatamean<-cooldata[,grep("mean",names(cooldata))]
cooldatastd<-cooldata[,grep("std",names(cooldata))]

## Recreate your dataset with only the mean and std dev data
## along with the subject and actiivty data, calling it "cooldatacombo"
cooldatacombo<-data.frame(subject=cooldata$subject,activity=cooldata$activity,
                          cooldatamean,cooldatastd)

## STEP 3:Use descriptive activity names to name the activities in the data set.
## Here is where I need to go into the "activity" column/vector, and change the 
## numeric values (1-6) to actual character strings that correspond with the 
## activities listed in the "activity_lables.txt" file. "Walking","Sitting", etc.

## Use the gsub() to swap out the numbers for the character strings
cooldatacombo<-as.character(cooldatacombo$activity)
cooldatacombo1<-gsub("1","walking", cooldatacombo)
cooldatacombo1<-gsub("2","walkingupstairs", cooldatacombo1)
cooldatacombo1<-gsub("3","walkingdownstairs", cooldatacombo1)
cooldatacombo1<-gsub("4","sitting", cooldatacombo1)
cooldatacombo1<-gsub("5","standing", cooldatacombo1)
cooldatacombo1<-gsub("6","laying", cooldatacombo1)

##Put the data set back together
cooldatafixed<-data.frame(subject=cooldata$subject,activity=cooldatacombo1,cooldatamean,cooldatastd)

## Step 4: Appropriately label the data set with descriptive activity names.
## I don't intend to change the label names for any of the 79 variables, as I have
## little understanding of the data that they represent. I will simply clean up the
## label names so that there isn't uppercase letters, symbols, white space, etc, that
## should not be there.

## Use the gsub() and tolower() to clean up the 79 labels of each column header
names(cooldatafixed)<-tolower(gsub("[^[:alnum:]]","", names(cooldatafixed)))

## Step 5: Creates a second, independent tidy data set with the average of 
## each variable for each activity and each subject. My assumptions about this
## is that it is asking for the averages of all 79 variables broken down by 
## "subject" and "actiivty" type. 30 subjects with 6 different activity types.

## First I will melt the "cooldatafixed" data set
## and get a long view of the data
library(reshape2)
cooldatasemi<-melt(cooldatafixed,id.vars=c("subject","activity"))

## Now I will recast the data into the wide format getting the mean for each
## variable for each subject for each activity
cooldatafinal<-dcast(cooldatasemi,subject+activity~variable, fun.aggregate = mean)

## I will then write this file into my directory so that I can upload onto
## the coursera website. Please note that I used the write.csv() and
## ultimately resaved the file as a pdf and uploaded the tidy.data.pdf
## file on the coursera assignment web site. 
write.csv(cooldatafinal,file="./data/UCIdata/tidy.data.csv",sep=" ")
