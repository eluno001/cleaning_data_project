# Reading the data

X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
activity<-read.table("./UCI HAR Dataset/activity_labels.txt")
features<-read.table("./UCI HAR Dataset/features.txt")
names(X_test)<-features[,2]
names(X_train)<-features[,2]

# Merging the data

testdata<-cbind(subject_test,Y_test,X_test)
traindata<-cbind(subject_train,Y_train,X_train)
data<-rbind(testdata,traindata)
names(data)[c(1,2)]<-c("subject","test_label")

# Measurments on the mean and sd

mean_sd_data <- data[,grep('subject|test_label|mean|median',names(data))]

# Descriptive activity names

mean_sd_data[,2]<-activity[mean_sd_data[,2],2]

# Descriptive variable names
        ## all done in lines 11,12 and 19

# Summarize variable with average for each activity and each subject

library(dplyr)
summary <- summarise_each(group_by(mean_sd_data,subject,test_label),funs(mean))
head(summary[,1:2],n=20)


# Output tidy table
write.table(summary,file="tidy_data.txt",row.name=FALSE)
