## ----------
## ReadXFile ()
## ----------

readXFile <- function (fileName, subjectsFile, activitiesFile, features, index) {
        ## Description:
        ## 1. Reads X files and formats 561 columns
        ## 2. Assign column names indicated by features
        ## 3. Filters for only columns indicated by index
        ## 4. Appends subjects and activities
        ## 5. Return a Data Frame
        
        # Read file
        data <- readLines(con <- file(fileName)) ; close.connection(con)
        
        # Collect records and convert to numeric, returns a matrix
        data <- sapply (data,function (x) {
                # Split by spaces each line read
                ret <- unlist(strsplit(x," "))
                
                # Remove empty elements
                ret <- ret[ret!=""]
                
                # Convert to numeric only Mean and Std features
                ret <- as.numeric(ret [index])
                
                return (ret)
        })
        
        # Assigns row and col names to the matrix that will be transpose
        colnames(data) <- NULL
        rownames(data) <- features$colName[index]
        
        # Read subjects and activities file
        subjects   <- readLines(con<-file(subjectsFile))   ; close.connection(con)
        activities <- readLines(con<-file(activitiesFile)) ; close.connection(con)
        
        # Transpose the matrix and append subjets info
        data <- cbind (data.frame(t(data)), subject=as.integer(subjects), activityid=activities)
        
        # Return data frame
        return (data)
}
