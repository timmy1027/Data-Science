## download data
if(!file.exists("./project_data/")){dir.create("./project_data/")}
fileUrL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrL, destfile = "./project_data/project_data.zip")
unzip(zipfile = "project_data.zip", exdir = "./project_data/" )

## Load activity and features data table
activitiesLabels <- read.table("./project_data/UCI HAR Dataset/activity_labels.txt", header = F)
features <- read.table("./project_data/UCI HAR Dataset/features.txt", header = F)
colnames(activitiesLabels) <- c("classLabels", "activityName")
colnames(features) <- c("index", "featureName")

featuresWanted <- grep("(mean|std)\\(\\)", features$featureName)
measurements <- features[featuresWanted, ]

## Load train datasets

train <- read.table("./project_data/UCI HAR Dataset/train/X_train.txt", header = F)
colnames(train) <- features$featureName
trainMeasured <- train[ ,measurements$featureName]

trainActivities <- read.table("./project_data/UCI HAR Dataset/train/y_train.txt", header = F)
trainSubjects <- read.table("./project_data/UCI HAR Dataset/train/subject_train.txt", header = F)
colnames(trainActivities) <- "classLabels"
colnames(trainSubjects) <- "SubjectIndex"

train <- cbind(trainSubjects, trainActivities, trainMeasured)

## load test datasets
test <- read.table("./project_data/UCI HAR Dataset/test/X_test.txt", header = F)
colnames(test) <- features$featureName
testMeasured <- test[, measurements$featureName]

testActivities <- read.table("./project_data/UCI HAR Dataset/test/y_test.txt", header = F)
testSubjects <- read.table("./project_data/UCI HAR Dataset/test/subject_test.txt", header = F)
colnames(testActivities) <- "classLabels"
colnames(testSubjects) <- "SubjectIndex"

test <- cbind(testSubjects, testActivities, testMeasured )

## merge test and train datasets
mered <- rbind(train, test)


mered$classLabels <- gsub("1", "WALKING", mered$classLabels)
mered$classLabels <- gsub("2", "WALKING_UPSTAIRS", mered$classLabels)
mered$classLabels <- gsub("3", "WALKING_DOWNSTAIRS", mered$classLabels)
mered$classLabels <- gsub("4", "SITTING", mered$classLabels)
mered$classLabels <- gsub("5", "STANDING", mered$classLabels)
mered$classLabels <- gsub("6", "LAYING", mered$classLabels)










