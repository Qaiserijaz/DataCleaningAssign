


libray(plyr)

if(!file.exists("./data")){
        dir.create('./data')
}
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile = "./data/Dataset.zip")
unzip(zipfile = "./data/dataset.zip", exdir = "./data")

# Reading the Train and Test data 

X_train<-read.table("C:\\Users\\CT\\Desktop\\R\\data\\UCI HAR Dataset\\train\\X_train.txt")
y_train<-read.table("C:\\Users\\CT\\Desktop\\R\\data\\UCI HAR Dataset\\train\\y_train.txt")
subject_train<-read.table("C:\\Users\\CT\\Desktop\\R\\data\\UCI HAR Dataset\\train\\subject_train.txt")

X_test<-read.table("C:\\Users\\CT\\Desktop\\R\\data\\UCI HAR Dataset\\test\\X_test.txt")
y_test<-read.table("C:\\Users\\CT\\Desktop\\R\\data\\UCI HAR Dataset\\test\\y_test.txt")
subject_test<-read.table("C:\\Users\\CT\\Desktop\\R\\data\\UCI HAR Dataset\\test\\subject_test.txt")

features<-read.table("C:\\Users\\CT\\Desktop\\R\\data\\UCI HAR Dataset\\features.txt")

activityLabels<-read.table("C:\\Users\\CT\\Desktop\\R\\data\\UCI HAR Dataset\\activity_labels.txt")

colnames(X_train)<-features[,2]
colnames(y_train)<-"activityId"
colnames(subject_train)<-"subjectiId"

colnames(X_test)<-features[,2]
colnames(y_test)<-"activityId"
colnames(subject_test)<-"subjectId"

colnames(activityLabels)<-c("activityId","subjectId")

# Merging the Data

mgr_train<-cbind(y_train,subject_train,X_train)
mgr_test<-cbind(y_test,subject_test,X_test)
setALLInOne<-rbind(mgr_train,mgr_test)


#  Extracting measurement on Mean and Standard deviation
 
colNames<-colnames(setALLInOne)

# Vector create for defining Id on mean and standard deviation

mean_and_std<-(grepl("activityId",colNames)|grepl("subjectId",colNames)|grepl("mean..",colNames)|grepl("std..",colNames))

# Getting subset from SetALLInOne

setForMeanAndStd<-setALLInOne[,mean_and_std== TRUE]



setWithActivityNames<-merge(setForMeanAndStd,activityLabels,by="activityId",all.x=TRUE)


# Descriptive activity names in Data set 


secTidySet<-aggregate(.~subjectId+activityId,setWithActivityNames,FUN = mean_and_std)
                   
# Creating Second Tidy set and writing data set in text file.

				   
secTidySet<-secTidySet[order(secTidySet$subjectId,secTidySet$activityId),]
write.table(secTidySet,"secTidyset.txt",row.names = FALSE)

