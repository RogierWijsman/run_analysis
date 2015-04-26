## Load data
  x_test  <- read.table("UCI HAR Dataset/test/X_test.txt")
  y_test  <- read.table("UCI HAR Dataset/test/y_test.txt")
  x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
  y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
  subject_train   <- read.table("UCI HAR Dataset/train/subject_train.txt")
  subject_test    <- read.table("UCI HAR Dataset/test/subject_test.txt")
  activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
  feature_names   <- read.table("UCI HAR Dataset/features.txt")

## Renaming columns
  names(activity_labels) <- c("activity_id","activity_name")
  names(x_test) <- feature_names[,2]
  names(y_test) <- "activity_id"
  names(subject_test) <- "subject_id"
  names(x_train) <- feature_names[,2]
  names(y_train) <- "activity_id"
  names(subject_train) <- "subject_id"
  
## Filter Columns
  x_test_mean  <- grep("mean()", names(x_test),value = TRUE, fixed = TRUE)
  x_test_std   <- grep("std()" , names(x_test),value = TRUE, fixed = TRUE)
  x_train_mean <- grep("mean()", names(x_train),value = TRUE, fixed = TRUE)
  x_train_std  <- grep("std()" , names(x_train),value = TRUE, fixed = TRUE)
  
  x_test_mean_data  <- x_test[,x_test_mean]
  x_test_std_data   <- x_test[,x_test_std]
  x_train_mean_data <- x_train[,x_train_mean]
  x_train_std_data  <- x_train[,x_train_std]
  
## Merge files
  xys_test <- cbind(subject_test,y_test,x_test_mean_data,x_test_std_data)
  xys_train <- cbind(subject_train,y_train,x_train_mean_data,x_train_std_data)
  merged_xys <- rbind(xys_test,xys_train)
  merged_xys_activ <- merge(merged_xys, activity_labels,  by = "activity_id")


##Summarize - library("plyr", lib.loc="~/R/win-library/3.1")

  summarized_data <- ddply(merged_xys_activ, .(activity_name,activity_id,subject_id), colwise(mean))
  
##create File
  
  write.table(summarized_data , file = "MyData.txt" ,col.names=TRUE, sep=",")
  
##Be Happy:)
  
 
  

