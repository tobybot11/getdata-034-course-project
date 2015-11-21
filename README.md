
# Course Project for "Getting and Cleaning Data" coursera course.
Original work .. Tobias Ford <toby.ford@pobox.com>

[Comes from](https://github.com/tobybot11/getdata-034-course-project)

[Inspirational Link](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/)

[Data comes from](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Description of the data comes from 
[this UCI link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Steps needed by run_analysis.R

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


execute "Rscript run_analysis.R" and then a file will be output
tidy_data.txt with the tidy data in it

requires dplyr library and the UCI HAR Dataset unzipped in this directory
