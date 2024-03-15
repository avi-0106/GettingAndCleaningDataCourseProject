---
title: "Getting and Cleaning Data Course project Codebook"
author: "avi-0106(GitHub)"
date: "2024-03-15"
output: html_document
---


## About the Source Data

The souce data for this project was collected from the accelerometers from the Samsung Galaxy S smartphone. The data with full description is available on the following website. <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

The Data used for this project is: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

## About the Variables in the R script

-   <mark>rawDataFilename</mark> stores the name of the compressed file of the raw data
-   <mark>rawDataFilenameURL</mark> stores the URL to get the data from
-   <mark>features</mark>, <mark>activity_labels</mark>, <mark>x_train</mark>,     <mark>y_train</mark>, <mark>subject_train</mark>,                             <mark>x_test</mark>, <mark>y_test</mark>, <mark>subject_test</mark> are       the variables that stores the data from the downloaded files.
-   <mark>x_data</mark>, <mark>y_data</mark>, <mark>subject_data</mark> and       <mark>merged_data</mark> stores the merged data for further analysis.
-   <mark>extracted_data</mark> stores the data specifically extracted to         perform further analysis mentioned in the project description.
-   <mark>tidyDataSet</mark> stores the final tidy data prepared as per the       instructions of the project description.


## About the R script
This R script involves 5 step in order to prepare the raw data as per the instruction provided on the Course Project's description. Before the steps begin, the raw data was collected from the source mentioned above.

1. Merging the training and testing data

      For this section the raw data stored in the variables x_train, y_train,       subject_train with the data in x_test, y_test, subject_test are merged        to form x_data, y_data and subject_data respectively.

2. Extracts only the measurements on the mean and standard deviation for each measurement

      For this section, the measurements are selected corresponding to the          mean and standard deviation for each feature.

3. Uses descriptive activity names to name the activities in the data set

      For this section, in the extracted data, the activity codes are replaced       with fully descriptive activity names from activity_labels table.

4. Appropriately labels the data set with descriptive variable names

      For this, all the variables are replaced with more descriptive variable       names in the extracted data.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

      For this final step, the tidy data is prepared using group_by() from          dpylr package.

The tidy data is exported and stored in the file with the name "tidyDataSet.txt".