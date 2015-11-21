run_analysis <- function() {

    # load dplyr library
    suppressPackageStartupMessages(library(dplyr, quietly=TRUE))
    
    # assumes the UCI HAR Dataset is unzipped in the current directory..
    # .gitignore ignores the zip file and the UCI HAR Dataset directory
    setwd('./UCI\ HAR\ Dataset/')

    # 4. Appropriately labels the data set with descriptive variable names - DONE above
    # LOAD the feature list and transform it into something more readable
    features_raw <- read.table("features.txt")
    features <- as.character(features_raw$V2)
    features <- gsub('mean', 'Mean', features)
    features <- gsub('std', 'Std', features)
    features <- gsub('-', '', features)
    features <- gsub('\\)', '', features)
    features <- gsub('\\(', '', features)
    features <- gsub('^t', 'Time', features)
    features <- gsub('^f', 'Freq', features)
    features <- gsub('^anglet', 'angleTime', features)
    features <- gsub(',g', 'G', features)
    
    # 3. Uses descriptive activity names to name the activities in the data set 
    # LOAD the labels file
    activities <- read.table("activity_labels.txt")
    colnames(activities) = c("activities_id", "Activity")

    # LOAD the data in from the files
    # data is split between test and train.. need to merge them together

    subject_test <- read.table("test/subject_test.txt")
    y_test <- read.table("test/y_test.txt")
    x_test <- read.table("test/X_test.txt")
    
    # Create a unified data.frame.. using native R calls .. except for that left_join
    sydf_test <- data.frame(subject_test, y_test)
    colnames(sydf_test) <- c('Subject', 'activities_id')
    sydf_test <- suppressMessages(left_join(sydf_test, activities))
    colnames(x_test) <- features
    syxdf_test <-data.frame(sydf_test, x_test)

    # tdf - is there a way to generalize this so i can use the same code for loading train data
    subject_train <- read.table("train/subject_train.txt")
    y_train <- read.table("train/y_train.txt")
    x_train <- read.table("train/X_train.txt")
    setwd('..')

    # Create a unified data.frame.. using native R calls
    sydf_train <- data.frame(subject_train, y_train)
    colnames(sydf_train) <- c('Subject', 'activities_id')
    sydf_train <- suppressMessages(left_join(sydf_train, activities))
    colnames(x_train) <- features
    syxdf_train <-data.frame(sydf_train, x_train)

    # 1. Merge the training and test sets to create one data set
    syx_df <- rbind(syxdf_test, syxdf_train)

    # 2. Extracts only the measurements on the mean and standard deviation for each measurement
    #   and the Subject and Activity as well
    syx_mean_std_df <- syx_df[, grep("(Subject|Activity|Mean|Std)", names(syx_df), value = TRUE)]

    # 5. From the data set in step 4.. creates a second, independent tidy data set 
    # with the average of each variable for each activity and each subject.
    aggregate(. ~ Activity + Subject, FUN="mean", data=syx_mean_std_df)
}

tidy_data <- run_analysis()

sink("/dev/null")
output_file <- "tidy_data.txt"
ifelse(file.exists(output_file), file.remove(output_file))
write.table(tidy_data, file=output_file, row.names=FALSE)

