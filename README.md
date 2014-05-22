## README for Getting and Cleaning Data course assignment

## I followed steps 1-5 in the course project. The following are descriptions of what I did for each step. The actual R script is located in the same repo that you find this README.md file, but in a separate file called tidy.data.R. Before you run the script, please ensure thatyou have downloaded the zip file and unzipped it into the working directory. You can find the data at the following website: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## STEP 1: Combine multiple data sets into a single data set to tidy up


## First I read in "features.txt" to get a data frame of 561 variables and assigned it to "features". Ultimately we only care about collumn V2, which contains a character vector of 561names of different kinds of measurements.


## Read in the X_Train, Subject_Train, and Y_Train data using read.table(). Also name all 561 variables using the variables from "features" and add in the "subject" and "activity" variable names Collumn bind all three data sets together calling it "train".


## Read in the X_Test, Subject_Test, and Y_Test data using read.table(). Also name all 561 variables using the variables from "features" and add in the "subject" and "activity" variable names Collumn bind all three data sets together calling it "test"


## Combine the two data sets of "train" and "test" using the rbind() to make a final tidy data set


## STEP 2: Extract out only the data that is related to the mean or  standard deviation, including the "subject" and "activity" columns as  well, and create a new data set. Please note that my assumptions about  ## this step are that we should only be pulling the variables that have  anything to do with the mean and standard deviation. I assumed that if the name of the variable contained the word "mean" or "std", it meant that the variable was related to the mean or std as a measurement.


## Use the grep function to pull out all columns that have the string  "mean" anywhere in header name. You will wind up with 79 columns. grep()  is able to locate 46 column headers with the string "mean" and 33 column  headers with the string "std". Add in your columns for "subject" and  "activity"and you have 81 total varibales in your new data set.


## Recreate your dataset with only the mean and std dev data along with the subject and actiivty data, calling it "cooldatacombo"


## STEP 3:Use descriptive activity names to name the activities in the data  set. Here is where I need to go into the "activity" column/vector, and   change the numeric values (1-6) to actual character strings that   correspond with the activities listed in the "activity_lables.txt" file. ## "Walking","Sitting", etc.

## Use the gsub() to swap out the numbers for the character strings


## Put the data set back together


## Step 4: Appropriately label the data set with descriptive activity names I don't intend to change the label names for any of the 79 variables, as  I have little understanding of the data that they represent. I will  simply clean up the label names so that there isn't uppercase letters,  symbols, white space, etc, that should not be there.

## Use the gsub() and tolower() to clean up the 79 labels of each column header


## Step 5: Creates a second, independent tidy data set with the average of  each variable for each activity and each subject. My assumptions about  this is that it is asking for the averages of all 79 variables broken  down by "subject" and "actiivty" type. 30 subjects with 6 different  activity types will yield 180 rows of data.

## First I will melt the "cooldatafixed" data set and get a long view of the data


## Now I will recast the data into the wide format getting the mean for  each variable for each subject for each activity


## I will then write this file into my directory so that I can upload onto the coursera website. Please note that I used the write.csv() and ultimately resaved the file as a pdf and uploaded the tidy.data.pdf file on the coursera assignment web site. I could have done it as a .txt file but it looked terrible in that format. The PDF version of the .csv looks much better. The actual .csv file written by my code looks the way it needs to.


