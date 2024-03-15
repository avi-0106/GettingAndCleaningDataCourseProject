library(dplyr)

rawDataFilename <- "GettingAndCleaningCourseProject_Data.zip"

if(!file.exists(rawDataFilename)){
  rawDataFilenameURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(rawDataFilenameURL,rawDataFilename) #download.file(raw_fileURL,destinationName)
}
if(!file.exists("UCI HAR Dataset")){
  unzip(rawDataFilename) 
}

#Assigning dataframes to the variables!
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

#Merging the training and the test sets to create one data set
x_data <- rbind(x_train,x_test)
y_data <- rbind(y_train,y_test)
subject_data <- rbind(subject_train,subject_test)
merged_data <- cbind(subject_data,y_data,x_data)

#Extracting only the measurements on the mean and standard deviation for each measurement
extracted_data <- merged_data %>% select(subject_data$subject,code,contains("mean"),contains("std"))

#Uses descriptive activity names to name the activities in the data set 
#bascially for this one, we are changing the code in extracted tidy data into the actual name of the Activity!
#2nd column is teh activity name!
extracted_data$code <- activity_labels[extracted_data$code, 2]

#Appropriately labels the data set with descriptive variable names
names(extracted_data)[2] = "activity"
names(extracted_data)<-gsub("Acc", "Accelerometer", names(extracted_data))
names(extracted_data)<-gsub("Gyro", "Gyroscope", names(extracted_data))
names(extracted_data)<-gsub("Mag", "Magnitude", names(extracted_data))
names(extracted_data)<-gsub("^t", "Time", names(extracted_data))
names(extracted_data)<-gsub("^f", "Frequency", names(extracted_data))
names(extracted_data)<-gsub("-mean()", "Mean", names(extracted_data), ignore.case = TRUE)
names(extracted_data)<-gsub("-std()", "STD", names(extracted_data), ignore.case = TRUE)
names(extracted_data)<-gsub("-freq()", "Frequency", names(extracted_data), ignore.case = TRUE)
names(extracted_data)<-gsub("angle", "Angle", names(extracted_data))
names(extracted_data)<-gsub("gravity", "Gravity", names(extracted_data))
names(extracted_data)<-gsub("tBody", "TimeBody", names(extracted_data))
names(extracted_data)<-gsub("BodyBody", "Body", names(extracted_data))
#case-insensitive - ignore.case = TRUE


#create a second, independent tidy data set with the average of each variable 
#for each activity and each subject
tidyDataSet <- group_by(extracted_data, subject, code) %>%
  summarise_all(mean)
#group_by(data, column1, column2, ...)


write.table(tidyDataSet, "tidyDataSet.txt", row.names = FALSE)





