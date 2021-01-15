## Getting and cleaning data project

if(!file.exists("./project_data")){dir.create("./project_data")}
fileUrL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrL, destfile = "./project_data/project_data.zip")
unzip("./project_data/project_data.zip", exdir="./project_data/")

## Load activity lebels and features
activityLabels <- read.table("./project_data/UCI HAR Dataset/activity_labels.txt", header = F)
colnames(activityLabels) <- c("classLabels", "activityName")
features <- read.table("./project_data/UCI HAR Dataset/features.txt", header = F)
colnames(features) <- c("index", "featureNames")

featuresWanted <- grep("(mean|std)\\(\\)", features$featureNames)
measurements <- features[featuresWanted, ]

## combine train datasets
TrainMeasure <- read.table("./project_data/UCI HAR Dataset/train/X_train.txt", header = F)
TrainActivities <- read.table("./project_data/UCI HAR Dataset/train/y_train.txt", header = F)
TrainSubjects <- read.table("./project_data/UCI HAR Dataset/train/subject_train.txt", header = F)
colnames(TrainMeasure) <- features$featureNames
colnames(TrainActivities) <- "Activities"
colnames(TrainSubjects) <- "SubjectNum"
TrainMeasureWanted <- TrainMeasure[, measurements$featureNames]

Train <- cbind(TrainSubjects, TrainActivities, TrainMeasureWanted)

## combine test datasets
TestMeasure <- read.table("./project_data/UCI HAR Dataset/test/X_test.txt", header = F)
TestActivities <- read.table("./project_data/UCI HAR Dataset/test/y_test.txt", header = F)
TestSubjects <- read.table("./project_data/UCI HAR Dataset/test/subject_test.txt", header = F)
colnames(TestMeasure) <- features$featureNames
colnames(TestActivities) <- "Activities"
colnames(TestSubjects) <- "SubjectNum"
TestMeasureWanted <- TestMeasure[, measurements$featureNames]
Test <- cbind(TestSubjects, TestActivities, TestMeasureWanted)

## merge datasets
merged <- rbind(Train, Test)

## reshape the datasets
library(reshape2)

head(melt(merged, id = c("SubjectNum", "Activities")), 10)

nrow(melt(merged, id = c("SubjectNum", "Activities")))

merged_melt <- melt(merged, id = c("SubjectNum", "Activities"))
merged_dcast <- dcast(merged_melt, SubjectNum + Activities ~ variable, mean)

write.table(merged_dcast, "reshaped.txt", sep = "\t", col.names = T, row.names = F)






