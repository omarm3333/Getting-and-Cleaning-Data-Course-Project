# Getting and Cleaning Data Course Project

## Scripts Descriptions

### run_analysis.R
Main R program does the functions calling and instructions to get and tidy data with the following actions:

1. Sets working directory with *setwd()*
2. Add library **dplyr**
3. Defines the path to source data directory: **"UCI HAR Dataset"**
4. Reads **activities** data frame with *read.delim()* defining headers and variable classes
5. Reads **features** data frame with *read.delim()* defining headers and variable classes
6. Append **colName** variable to features with **originalColNames** but removing special characters "*()-*" and replacing these by "*.*"
7. Create an index vector of features that contains only the words "**Mean**" and "**Std**" in the feature name (case insensitive)
8. Call *readXFile()* to read **test** and **train** data files (*X_train.txt* and *X_test.txt*) and merge *activityid* and *subjectid*. Returns ONLY the columns indicated by the vector created in the previous step (*indexMeanStdFeatures*)
9. Row bind both data frames (test and train data)
10. Merge to resulting *activityData* the activities detailed descriptions
11. From *activityData* create a new data frame summarizing all numeric values with means, except activityid; grouped by activity and subject. Resuts in *groupedActivityDataMeans* data frame
12. Append to *groupedActivityDataMeans* means column names the word "**.Mean**" in order to identify these as summirized columns of means.
13. Save to CSV files both data frames "*activityData*" and "*groupedActivityDataMeans*"
14. Result tidy data files are:
 * **activitydata.csv** for detailed X data files for both test and training data
 * **groupedactivitydatameans.csv** for grouped and summirized records of *activityData*

### run_analysis_func.R
#### *readXFile (fileName, subjectsFile, activitiesFile, featureNames, index) Function*

   fileName : Path and filename of the X file to read (*X_train.txt* or *X_test.txt*)
   subjectsFile : Path and file name of subjects (*subject_train.txt* or *subject_test.txt*)
   activitiesFile : Path and file name of subjects (*y_train.txt* or *y_test.txt*)
   featureNames : Character vector with feature column names
   index : Numeric index vector with the columns that are **Mean** or **Std** related
   
Description: Reads data *filename* (*X_train.txt* or *X_test.txt*), filters only features indicated by *index* logical vector. Name headers with *features* names and merge *subjectsFile* and *activitiesFile* information to resulting data frame.

1. Read lines of data *filename*
2. Iterate with *sapply()* in every line read to split line by spaces and remove empty variables, total of 561 variables per record. 
3. Assing names of featureNames to resulting matrix and transpose to a data fame
4. Read *subjectsFile* and *activitiesFile* files and column bind subjectsid and activityid for every record of data frame 
5. Return resulting Data Frame with only columns of "**Mean**" or "**Std**" text in the name.