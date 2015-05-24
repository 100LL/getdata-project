library(dplyr)
library(tidyr)

# read in the data and feature labels
features <- read.table("UCI HAR Dataset/features.txt", colClasses="character")
test  <- read.table("UCI HAR Dataset/test/X_test.txt", col.names=features[,2])
train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names=features[,2])
rm(features)

# read in the activity labels
testActivity  <- read.table("UCI HAR Dataset/test/y_test.txt", 
			    colClasses = "factor", col.names = "activity")
trainActivity <- read.table("UCI HAR Dataset/train/y_train.txt", 
			    colClasses = "factor", col.names = "activity")

# read in the subject labels
testSubject  <- read.table("UCI HAR Dataset/test/subject_test.txt", 
			   colClasses = "factor", col.names = "subject")
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt", 
			   colClasses = "factor", col.names = "subject")

# attach the measurement labels to the data set
test  <- cbind(testSubject,  testActivity,  test)
train <- cbind(trainSubject, trainActivity, train)
rm(testSubject, testActivity, trainSubject, trainActivity)

# merge the two data sets into one
combined <- rbind(test, train)
rm(test, train)

# select only the mean and standard deviation measurements
filtered <- cbind(combined[, c(1,2)], 
		  select(combined, matches("\\.(mean|std)\\.")))
rm(combined)

# replace the activity numbers with corresponding names
# and clean up the measurement names
activities <- read.table("UCI HAR Dataset/activity_labels.txt",
			 colClasses="character")
for(a in activities[,1]) {
	filtered[,2]  <- gsub(a, activities[a,2], filtered[,2])
}
rm(a, activities)
names(filtered) <- sub("\\.{3}X", "-X", names(filtered))
names(filtered) <- sub("\\.{3}Y", "-Y", names(filtered))
names(filtered) <- sub("\\.{3}Z", "-Z", names(filtered))
names(filtered) <- sub("\\.{2}$", "", names(filtered))

# create a second data set that contains the averages of each measurement
# for each subject/activity combination
UCI_HAR_avg <- with(filtered, aggregate(filtered[, 3:68], 
		by=list(subject=subject, activity=activity), FUN=mean))

write.table(UCI_HAR_avg, file="UCI_HAR_avg.txt", row.names=FALSE)
