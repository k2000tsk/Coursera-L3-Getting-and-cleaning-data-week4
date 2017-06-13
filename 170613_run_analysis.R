
# file read & merge
train_file<-read.csv("train/X_train.txt",sep="",header=FALSE)
test_file<-read.csv("test/X_test.txt",sep="",header=FALSE)
merged_file<-rbind(train_file, test_file)   # merged file(10299 rows, 561 columns)

# file read y and merge
train_file_y<-read.csv("train/y_train.txt",sep="",header=FALSE)
test_file_y<-read.csv("test/y_test.txt",sep="",header=FALSE)
merged_file_y<-rbind(train_file_y,test_file_y)  # merged y file(10299 rows, 1 column)

# file read subject and merge
train_file_subject<-read.csv("train/subject_train.txt",sep="",header=FALSE)
test_file_subject<-read.csv("test/subject_test.txt",sep="",header=FALSE)
merged_file_subject<-rbind(train_file_subject,test_file_subject)  # merged subject file(10299 rows, 1 column)

# read additional file(features & activity labels)
featured_list<-read.csv("features.txt",sep="",header=FALSE)  # 561 rows, 2 columns
activity_labels<-read.csv("activity_labels.txt",sep="",header=FALSE)  # 6 rows, 2 columns

# view featured_list and grep "mean" & "std"
# store the variable "featured_mod"
# View(featured_list)
featured_modified1<-grep("mean",featured_list[,2])
featured_modified2<-grep("std",featured_list[,2])
featured_mod<-c(featured_modified1,featured_modified2)
featured_mod<-sort(featured_mod) 

# extract the "mean" & "std" in all_data
merged_file_new<-merged_file[,featured_mod]

# match the file y with activity names
# activity names in the variable "merged_file_y
i<-1
j<-1
for(i in 1:nrow(activity_labels)){
  for(j in 1:nrow(merged_file_y)){
    if(merged_file_y[j,1]==i){
      merged_file_y[j,1]<-as.character(activity_labels[i,2])
    }
    else{
      merged_file_y[j,1]<-merged_file_y[j,1]
    }
  }
}

# merge Activity, Subject, X in new variable, "all_data"
# all_data has 563 columns(561+1+1)
all_data<-cbind(merged_file_y,merged_file_subject,merged_file_new)
head(all_data)  # check the number of columns

# designate the column names in "all_data"
featured_list<-as.character(featured_list[,2])
featured_list_mod<-featured_list[featured_mod]
colnames(all_data) <- c("Activity","Subject",featured_list_mod)

# count the number of activities & subjects
num_of_activity<-unique(activity_labels)
num_of_subject<-unique(merged_file_subject)

# calculate the average of each variable for each activity & subject
i<-1
j<-1
r<-1
final_result<-all_data[1:(nrow(num_of_activity)*nrow(num_of_subject)),]
for(i in 1:nrow(num_of_activity)){
  for(j in 1:nrow(num_of_subject)){
      final_result[r,1]<-as.character(num_of_activity[i,2])
      final_result[r,2]<-j
      temp <- all_data[all_data[,1]==as.character(num_of_activity[i,2]) & all_data[,2]==j,]
      final_result[r,3:(ncol(all_data)-2)]<-colMeans(temp[,3:(ncol(all_data)-2)],na.rm=FALSE)
      r<-r+1
  }
}

# store the CSV file, which name is "final_result.txt"
write.table(final_result,"final_result.txt",sep="\t")
