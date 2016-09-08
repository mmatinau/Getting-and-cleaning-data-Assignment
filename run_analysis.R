## Script name: run_analysis.R

## Assumption: UCI HAR Dataset has been unzipped to R working directory

## Calling the libraries that will be used 
library (data.table)
library (dplyr)

## Reading metadata files from Original dataset
featureNames <- read.table ("UCI HAR Dataset/features.txt", header = FALSE)
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

## Reading and Formatting data:
## Both training and test data sets are split into subject id, activity labels and their values (features)
## Reading training data set
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)

## Reading test data set
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
activityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)


################### PART 1 ####################

## Merging the train and test data
subject <- rbind (subjectTrain, subjectTest)
features <- rbind (featuresTrain, featuresTest)
activity <- rbind (activityTrain, activityTest)

### Renaming the columns of "features" by using transpose function over metadata. 
### For the other two giving new column names
colnames(features) <- t(featureNames[2])
colnames (subject) <- "Subject"
colnames(activity) <- "Activity"

### All three tables now have same number of observations (rows), so merging by column binding
completeDT <- cbind (subject, activity, features) 


################### PART 2 ####################

## From complete data extracting the column indices with mean and std values
colInd <- grep(".*Mean.*|.*Std.*|Subject|Activity", colnames(completeDT), ignore.case=TRUE)

## Getting the extracted data set by selecting the required columns
extractDT <- completeDT [, colInd]
  

################### PART 3 ####################

## Replace Activity entries in extractDT by names in metadata 'activityLabels' 
### Changing the class of extractDT$"Activity" from numeric to character
extractDT$"Activity" <- as.character (extractDT$"Activity")

### Running a conditional for loop on the extractDT$"Activity" column only to update activity
### description
for (i in 1:6) {
extractDT$"Activity" [extractDT$"Activity" == i] <- as.character (activityLabels [i,2])
}

### As part of tidying up extractDT$"Activity" and extractDT$"Subject" entries are converted to facors from characters
extractDT$"Activity" <- as.factor (extractDT$"Activity")
extractDT$"Subject" <- as.factor(extractDT$"Subject")

################### PART 4 ####################

## See the column names of extractDT using colnames() or names()
names (extractDT)

## From Readme.txt file in original data set, we can decide that 
## 't' = Time, 'f' = Frequency, Acc = Accelerometer, Gyro = Gyroscope, BodyBody = Body, Mag = Magnitude etc.
names(extractDT)<-gsub("Acc", "Accelerometer", names(extractDT))
names(extractDT)<-gsub("Gyro", "Gyroscope", names(extractDT))
names(extractDT)<-gsub("Mag", "Magnitude", names(extractDT))
names(extractDT)<-gsub("angle", "Angle", names(extractDT))
names(extractDT)<-gsub("gravity", "Gravity", names(extractDT))
names(extractDT)<-gsub("^t", "Time", names(extractDT))
names(extractDT)<-gsub("^f", "Frequency", names(extractDT))
names(extractDT)<-gsub("-mean()", "Mean", names(extractDT), ignore.case = TRUE)
names(extractDT)<-gsub("-std()", "STD", names(extractDT), ignore.case = TRUE)
names(extractDT)<-gsub("-freq()", "Frequency", names(extractDT), ignore.case = TRUE)
names(extractDT)<-gsub("tBody", "TimeBody", names(extractDT))
names(extractDT)<-gsub("BodyBody", "Body", names(extractDT))


################### PART 5 ####################

## Grouping the dataset from Part 4 by Subject and Activity Label

## Wrapping data using data.table package
extractDT <- data.table(extractDT)

## Passing mean function to columns 3 to 88, and re-arranging them
tidyDT <- aggregate(. ~Subject + Activity, extractDT, mean)
tidyDT <- tidyDT[order(tidyDT$Subject,tidyDT$Activity),]

## Writing the final tidy data set
write.table(tidyDT, file = "Tidy Data Set.txt", row.names = FALSE)
