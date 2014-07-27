##run_analysis.R

##
#You should create one R script called run_analysis.R that does the following. 
#1.Merges the training and the test sets to create one data set.
#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#3.Uses descriptive activity names to name the activities in the data set.
#4.Appropriately labels the data set with descriptive variable names. 
#5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
##

setwd("~/RStudio/Projects/GettingAndCleaningDataPeerA1/GettingAndCleaningDataPeerA1")

#get X_train dataset
X_train.filename <- "X_train.txt"
X_train.data <- read.table(X_train.filename)

#get Y_train dataset
Y_train.filename <- "Y_train.txt"
Y_train.data <- read.table(Y_train.filename)
dimnames(Y_train.data)[[2]] <- "YV1"

#get subject_train dataset
subject_train.filename <- "subject_train.txt"
subject_train.data <- read.table(subject_train.filename)
dimnames(subject_train.data)[[2]] <- "SV1"

#merge X_train and Y_train to All_train
All_train.data <- cbind(X_train.data,Y_train.data,subject_train.data)

#get X_test dataset
X_test.filename <- "X_test.txt"
X_test.data <- read.table(X_test.filename)

#get Y_test dataset
Y_test.filename <- "Y_test.txt"
Y_test.data <- read.table(Y_test.filename)
dimnames(Y_test.data)[[2]] <- "YV1"

#get subject_test dataset
subject_test.filename <- "subject_test.txt"
subject_test.data <- read.table(subject_test.filename)
dimnames(subject_test.data)[[2]] <- "SV1"

#merge X_test and Y_test to All_test
All_test.data <- cbind(X_test.data,Y_test.data,subject_test.data)

#merge All_train and All_test to All_data
All_data <- rbind(All_train.data, All_test.data)
#point 1 done
##================================================================


#get features for column names
features.filename <- "features.txt"
features.data <- read.table(features.filename)

cols <- grep("*mean*|*std*",features.data$V2)

temp <- features.data[grep("*mean*|*std*",features.data$V2),]
temp <- temp[!grepl("*meanFreq*",temp$V2),]

cols <- temp$V1
rm(temp)

#add activity label and subject columns to filter
cols <- append(cols,562)
cols <- append(cols,563)
#extract selected columns
All_data_extracted <- All_data[,cols]
#point 2 done 
##================================================================


#translate Y_test/Y_train column from digits to string using activity_label.txt
activity_labels.filename <- "activity_labels.txt"
activity_labels.data <- read.table(activity_labels.filename, col.names = c("YV1","activity_label"))

All_data_extracted_ <- merge(All_data_extracted, activity_labels.data, by="YV1")
#drop YV1 column
All_data_extracted_ <- subset(All_data_extracted_, select=-YV1)
#point 3 done
##================================================================


#rename columns in All_data using features
cols_ <- grep("*mean*|*std*",features.data$V2)

temp <- features.data[grep("*mean*|*std*",features.data$V2),]
temp <- temp[!grepl("*meanFreq*",temp$V2),]

cols_ <- temp$V1
rm(temp)

colN <- features.data[cols_,2]
names(All_data_extracted_) <- features.data[cols_,2]
#add activity label and subject columns to filter

names(All_data_extracted_)[67] <- "Subject"
names(All_data_extracted_)[68] <- "Activity_label"
#points 4 done
##================================================================


#calculate average
library("plyr")
x <- ddply(All_data_extracted_, .(Subject,Activity_label), numcolwise(mean))
write.csv(x, "filename.txt")
#point 5 done
##================================================================