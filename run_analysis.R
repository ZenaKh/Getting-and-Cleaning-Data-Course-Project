## Read data
subjectTest <- read.table("D:/Study/datascientist/week4Cours3/UCI HAR Dataset/test/subject_test.txt")
Ytest <- read.table("D:/Study/datascientist/week4Cours3/UCI HAR Dataset/test/y_test.txt")
Xtest <- read.table("D:/Study/datascientist/week4Cours3/UCI HAR Dataset/test/X_test.txt")
subjectTraining <- read.table("D:/Study/datascientist/week4Cours3/UCI HAR Dataset/train/subject_train.txt")
Ytraining <-read.table("D:/Study/datascientist/week4Cours3/UCI HAR Dataset/train/y_train.txt")
Xtraining <- read.table("D:/Study/datascientist/week4Cours3/UCI HAR Dataset/train/X_train.txt")
features <- read.table("D:/Study/datascientist/week4Cours3/UCI HAR Dataset/features.txt")
activityLabels <- read.table("D:/Study/datascientist/week4Cours3/UCI HAR Dataset/activity_labels.txt")

##giving a names to the columns
colnames(subjectTest) <- "subject"
colnames(subjectTraining) <- "subject"
colnames(activityLabels) <- c("activity","activityname")
colnames(Ytest) <- "activity"
colnames(Ytraining) <- "activity"
colnames(Xtest) <- features[ ,2]
colnames(Xtraining) <- features[ ,2]


## merging data
## all data of the test with all data of the training
AllData <- rbind(cbind(subjectTest, Ytest, Xtest), cbind(subjectTraining, Ytraining, Xtraining))

## taking the columns with mean() and std()
colnames <- colnames(AllData)
AllDataMeanStd <- AllData[ ,(grepl("activity" , colnames) | grepl("subject" , colnames) | grepl("mean.." , colnames) | grepl("std.." , colnames))]
##adding the column activity Type
AllDataMeanStdActiviry <- merge(AllDataMeanStd, activityLabels, by='activity', all.x=TRUE)
##cleaning column names
colnames <- colnames(AllDataMeanStdActiviry)
for (i in 1:length(colnames)) 
{
  colnames[i] <- gsub("\\()","",colnames[i])
  colnames[i] <- gsub("-std","Std",colnames[i])
  colnames[i] <- gsub("-mean","Mean",colnames[i])
  colnames[i] <- gsub("^(t)","time",colnames[i])
  colnames[i] <- gsub("^(f)","freq",colnames[i])
  colnames[i] <- gsub("-X","X",colnames[i])
  colnames[i] <- gsub("-Y","Y",colnames[i])
  colnames[i] <- gsub("-Z","Z",colnames[i])
  
}

colnames(AllDataMeanStdActiviry) <- colnames


## tidy data set with the average of each variable for each activity and each subject
tidyData = aggregate(. ~subject + activity + activityname, AllDataMeanStdActiviry, mean)

##put data to the file
write.table(tidyData, "D:/Study/datascientist/week4Cours3/UCI HAR Dataset/tidyData.txt", row.names=FALSE, sep='\t')







