## ----------
## ReadXFile ()
## ----------

readXFile <- function (fileName, subjectsFile, activitiesFile, featureNames, index) {
        ## Description:
        ## 1. Reads X files and formats 561 columns
        ## 2. Assign column names indicated by featureNames
        ## 3. Filters for only columns indicated by index
        ## 4. Appends subjects and activities
        ## 5. Return a Data Frame
        
        # Read files
        data       <- read.table(fileName,        header = FALSE, col.names = featureNames)
        subjects   <- read.table (subjectsFile,   header = FALSE, col.names = "subject")
        activities <- read.table (activitiesFile, header = FALSE, col.names = "activityid")

        # Attach subjects and activities         
        data <- cbind (activityid=activities, subject=subjects, data[,index])
        
        # Return data frame with only Mean and Std columns
        return (data)
}
