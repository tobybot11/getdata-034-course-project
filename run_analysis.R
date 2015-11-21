run_analysis <- function() {

    # assumes the UCI HAR Dataset is unzipped in the current directory..
    # .gitignore ignores the zipe file and the UCI HAR Dataset directory

setwd('./UCI\ HAR\ Dataset/')
d <- dir()

# LOAD the feature list
features_raw <- read.table("features.txt")
features <- as.character(features_raw$V2)

# LOAD the data in from the files
# data is split between test and train.. need to merge them together

# tdf .. should i do some error checking on the read.tables?  
subject_test <- read.table("test/subject_test.txt")
y_test <- read.table("test/y_test.txt")
x_test <- read.table("test/X_test.txt")

# Create a unified data.frame.. using native R calls
sydf_test <- data.frame(subject_test, y_test)
# tdf - should i add in the long name of the activity?
colnames(sydf_test) <- c('subject', 'activity')
colnames(x_test) <- features
syxdf_test <-data.frame(sydf_test, x_test)

# tdf - is there a way to generalize this so i can use the same code for loading train data
subject_train <- read.table("train/subject_train.txt")
y_train <- read.table("train/y_train.txt")
x_train <- read.table("train/X_train.txt")

# Create a unified data.frame.. using native R calls
sydf_train <- data.frame(subject_train, y_train)
# tdf - should i add in the long name of the activity?
colnames(sydf_train) <- c('subject', 'activity')
colnames(x_train) <- features
syxdf_train <-data.frame(sydf_train, x_train)

# 1. Merge the training and test sets to create one data set
syx_df <- rbind(syxdf_test, syxdf_train)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
syx_mean_std_df <- syx_df[, grep("(subject|activity|mean|std)", names(syx_df), value = TRUE)]

# tdf - would be cool to create a timers file to keep track of how long each run took.. 
print(head(syx_mean_std_df))

# 3. Uses descriptive activity names to name the activities in the data set

# 4. Appropriately labels the data set with descriptive variable names

# 5. From the data set in step 4.. creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.


# closure
setwd('..')

syx_mean_std_df
}

syx_mean_std_df <- run_analysis()
