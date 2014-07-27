Code Book
=========

A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

As I mention in [README.md][], I need to made these steps for this assessment:

1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set.
4.Appropriately labels the data set with descriptive variable names. 
5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 



####Merges the training and the test sets to create one data set.


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

In this step I collect infomation from data sources by using `read.table()` and create united datasource `All_data`

####Extracts only the measurements on the mean and standard deviation for each measurement. 

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

In this step I collect infomation from featuse datasource, filter column nanes by "mean" and "std", create united datasource `All_data_extracted`

####Uses descriptive activity names to name the activities in the data set.

        #translate Y_test/Y_train column from digits to string using activity_label.txt
        activity_labels.filename <- "activity_labels.txt"
        activity_labels.data <- read.table(activity_labels.filename, col.names = c("YV1","activity_label"))
        
        All_data_extracted_ <- merge(All_data_extracted, activity_labels.data, by="YV1")
        #drop YV1 column
        All_data_extracted_ <- subset(All_data_extracted_, select=-YV1)

In this step I joined activity labels dataset and main dataset by activity ID in `YV1` column

####Appropriately labels the data set with descriptive variable names. 

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


In this step I renamed columns in `All_data_extracted_` by features data


####Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

        #calculate average
        library("plyr")
        x <- ddply(All_data_extracted_, .(Subject,Activity_label), numcolwise(mean))
        write.csv(x, "filename.csv")

Here I aggreagate data using `ddply()` function from "plyr" package and write data to [filename.csv][]




[filename.csv]: https://github.com/mkhozeev/GettingAndCleaningDataPeerA1        "filename.csv"
[run_analysis.R]:       https://github.com/mkhozeev/GettingAndCleaningDataPeerA1        "run_analysis.R"
[README.md]:       https://github.com/mkhozeev/GettingAndCleaningDataPeerA1        "README.md"
[CodeBook.md]:       https://github.com/mkhozeev/GettingAndCleaningDataPeerA1        "CodeBook.md"