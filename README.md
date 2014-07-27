Getting and Cleaning Data, Peer Assessment 1
============================================

This is a README.md file for explain how all of the scripts work and how they are connected.

Contents
--------

* Task overwiev
* Steps made
* Datasets
* run_analysis.R
* Results

Task overwiev
-------------

The main goals of this project are:
- ability to generate tidy dataset
- using GitHub for share results
- comment and describe code

Steps made
----------

I downloaded [datasets](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), unzip it to my working directory, create [run_analysis.R][] file with code and upload it to my GitHub repo [called GettingAndCleaningDataPeerA1](https://github.com/mkhozeev/GettingAndCleaningDataPeerA1, "link to my GitHub"). Also I made [README.md][] and [CodeBook.md][] files with tasks and dataset descritions. Results wrote into [filename.csv][] file.

Datasets
--------

As I learned from README.txt dataset for this assesment is:

>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

Regardind data I got these links: `train/X_train.txt` and `test/X_test.txt` - main source of data, `features.txt` - columns names for datasource, `activity_labels.txt` - readable names for `train/y_train.txt` and `test/y_test.txt` -- datasets of activities; `subject_train.txt` and `subject_test.txt` - 30 volunteers IDs.

run_analysis.R
--------------

So I need to made next steps:

#####Merges the training and the test sets to create one data set
+get `X_train` and `X_test` datasets 
+get `Y_train` and `Y_test`` datasets (activity labels)
+get `subject_train` and `subject_test` datasets (subjects id's)
+unite all datasets in one, called `All_data`

For getting information I use `read.table(filename)`, for dataset unite `cbind()` and `rbind()` 

#####Extracts only the measurements on the mean and standard deviation for each measurement
+get features for column names
+filter column names, contains "mean" and "std", but not "meanFreq"
+create dateset with nesessary columns

For filtering I use `grep("*mean*|*std*",features)`

#####Uses descriptive activity names to name the activities in the data set.
+translate Y_test/Y_train column from digits to string using activity_label.txt
+merge `activity_labels` and dataset from previous step

For join datasets I use `merge()` function

#####Appropriately labels the data set with descriptive variable names. 
+rename columns in All_data using features information
+add activity label and subject columns to filter

For rename columns I use `names()`  function

#####Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
In this step I aggregated information from dataset by activity and subject columnt using `ddply()` function from "plyr" and save results by using `write.csv(x, "filename.csv")`

Results
-------

I create [filename.csv][] with tidy aggregated dataset by my [run_analysis.R][] code, [README.md][] and [CodeBook.md][] files with tasks and dataset descritions.





[filename.csv]: https://github.com/mkhozeev/GettingAndCleaningDataPeerA1        "filename.csv"
[run_analysis.R]:       https://github.com/mkhozeev/GettingAndCleaningDataPeerA1        "run_analysis.R"
[README.md]:       https://github.com/mkhozeev/GettingAndCleaningDataPeerA1        "README.md"
[CodeBook.md]:       https://github.com/mkhozeev/GettingAndCleaningDataPeerA1        "CodeBook.md"


