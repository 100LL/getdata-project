# Course Project for Getting and Cleaning Data
The R script run_analysis.R transforms a data set according to the instructions given for the Getting and Cleaning Data course project.  The original file can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 

Summary of steps performed by the script:  
1. Read in activity, subject, and feature labels.  
2. Read in the test and training data and apply feature labels.  
3. Attach the activity and subject labels to each of the test and training data sets.  
4. Combine the test and training sets into one.  
5. Filter out only the mean and standard deviations of each measurement.  
6. Replace activity numbers with corresponding names and clean up variable names.  
7. Create the final data set UCI_HAR_avg which is the average of each variable for each subject/activity combination.  


The instructions stated that the script should do the following:  
1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.   
3. Uses descriptive activity names to name the activities in the data set  
4. Appropriately labels the data set with descriptive variable names.   
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

