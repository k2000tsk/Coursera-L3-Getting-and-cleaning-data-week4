# Getting and cleanind data(week4) - assignment

## Purpose
demonstrate ability to collect, work with, and clean a data set

## What to do
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement.
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names.
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## data source
 dataset : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 
## input file
  1. X_train.txt / X_test.txt : dataset
  2. y_train.txt / y_test.txt : data label(standing, sitting, laying, walking, walking downstairs, walking upstairs)
  3. subject_train.txt / subject_test.txt : ID of volunteers (range : 1~30)
  4. activity_labels.txt : IDs and names of each activity
  5. features.txt : list of all features
  
## explain my variable
  1. merged_file / merged_file_y, merged_file_subject : read txt file
  2. featured_mod : include "mean", "std" among feature lists
  3. all_data : merge(data_x, data_y, data_subject)
  4. final_result : calculate mean of each activity and subject
