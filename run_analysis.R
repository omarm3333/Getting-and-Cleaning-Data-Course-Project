setwd("~/Documents/Cisco/6) DataScience/Getting and Cleaning Data/Assignment")

library(dplyr)
source("run_analysis_func.R")

# Path to root data directory
data_path <- "UCI HAR Dataset"

# Read activities descriptive name's file
activities <- read.delim (file.path(data_path, "activity_labels.txt"), 
                       sep = " ", header=FALSE, 
                       col.names  = c("activityid","activity"),
                       colClasses = c("factor","factor")
                     )

# Read Features file
features <- read.delim (file.path(data_path, "features.txt"), 
                          sep = " ", header=FALSE, 
                          col.names  = c("featurenum","originalColName"),
                          colClasses = c("integer","character")
)

# Remove special characters from features colNames names: '(),'
features$colName <- features$originalColName %>% 
        gsub("()", "", ., fixed = TRUE) %>%             # Remove emptry parenthesis
        gsub(",|\\(", ".", .) %>%                       # Replace commas and non-empty left parenthisis
        gsub("\\)$", "", .) %>%                         # Remove right end parenthesis
        gsub("-", ".", .)

# Create a numeric index of features with only Mean and Std measures
indexMeanStdFeatures <- features$featurenum [grepl("mean|std", features$colName)]

# Read Train and Test records with only Mean and Std Features variables
activityData <- rbind(
                readXFile (
                        file.path(data_path, "train", "X_train.txt"),
                        file.path(data_path, "train", "subject_train.txt"),
                        file.path(data_path, "train", "y_train.txt"),
                        features$colName, 
                        indexMeanStdFeatures),
                readXFile (
                        file.path(data_path, "test", "X_test.txt"),
                        file.path(data_path, "test", "subject_test.txt"),
                        file.path(data_path, "test", "y_test.txt"),
                        features$colName, 
                        indexMeanStdFeatures)
        )

# Merge activities description and group by subject
activityData <- merge (activityData, activities) 

# Build grouped means by Activity and Subject
groupedActivityDataMeans <- activityData %>%
        group_by (activity, subject) %>%
        summarise_each (funs(mean), -activityid)

# Append ".Mean" to summary column names
names(groupedActivityDataMeans)[3:length(groupedActivityDataMeans)] <- paste0(
                names(groupedActivityDataMeans)[3:length(groupedActivityDataMeans)],".Mean"
        )

# Output activityData to CSV file: activitydata.csv
write.csv(activityData, "activitydata.csv")

# Output groupedActivityData to CSV file: groupedactivitydata.csv
write.csv(groupedActivityDataMeans, "groupedactivitydatameans.csv")
