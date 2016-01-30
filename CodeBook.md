Omar Marquina

# Analysis of Human Activity Recognition Using Smartphones Data Set

Summary: The porpuse of this analysis is to get, clean, arrange and summarize data for Coursera Getting and Cleaning Data Course Project. The data were taken from Human Activity Recognition Using Smartphones Study (Detailed description of Study found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). Only information from Means and Standar Deviation variables (main features) from this study were considered for analysis. Data from all activities and all subjects were joint in CSV file called "activitydata.csv" and the means summary for Activity and Subject groups is saved to "groupedActivityDataMeans.csv".

## Extent of Source Data
Located in this url: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Files structure:
        * activity_labels.txt : activityLevelIds, descriptions. 6 activities. Space separated
        * features.txt : feaureIndex, featureName. 561 features, Space separated
        * test folder : Test Subjects detail activity data
                * Inertial Signals : Folder with detailed inertial signal not considered for this work
                * subject_test.txt : subjectNumber records, one line per observation (2,947 test subjects)
                * y_test.txt : activityId records, activity perfomed one line per observation (2,947 test subjects)
                * X_test.txt : 561 features measured for each observation (2,947 test subjects). Space separated
        *train folder : Test Subjects detail activity data
                * Inertial Signals : Folder with detailed inertial signal not considered for this work
                * subject_train.txt : subjectNumber records, one line per observation (7,352 train subjects)
                * y_train.txt : activityId records, activity perfomed one line per observation (7,352 train subjects)
                * X_train.txt : 561 features measured for each observation (7,352 train subjects). Space separated

         
## Extent of Processing 
        1) Activities and Features index tables read initially
        2) Features names cleared and transformed on:
                * Empty Parenthesis "()"   : Removed
                * Parenthesis with content : Open parenthesis replaced with "." and closing parenthesis removed from the end of the line. 
                * Dashes "-"               : Replaced by "."
        3) Identify index of features with "Mean" and "Std" in feature's name
        4) Join subject, activity id and features of train subjects
        5) Join subject, activity id and features of test subjects
        6) Row bind both previous data frames
        7) Merge it Activities descriptions
        8) Create summary data frame from previous joint, grouped by activity and subject and sumarizing variables calculating means for each variable, except activityid
        9) Save both data frames to CSV files
 
 