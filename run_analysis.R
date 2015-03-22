
#New data set for all measurements, read in temp data files and merged

temp_data1 <- read.table("train/X_train.txt")
temp_data2 <- read.table("test/X_test.txt")
var_X <- rbind(temp_data1, temp_data2)

temp_data3 <- read.table("train/subject_train.txt")
temp_data4 <- read.table("test/subject_test.txt")
subj <- rbind(temp_data3, temp_data4)

temp_data5 <- read.table("train/y_train.txt")
temp_data6 <- read.table("test/y_test.txt")
var_Y <- rbind(temp_data5, temp_data6)

#Reads features, extracts mean and standard deviation

features <- read.table("features.txt")
indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
var_X <- var_X[, indices_of_good_features]
names(var_X) <- features[indices_of_good_features, 2]
names(var_X) <- gsub("\\(|\\)", "", names(var_X))
names(var_X) <- tolower(names(var_X))

# Reads activity labels, assigns names to data set, writes tidy data into a file

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
var_Y[,1] = activities[var_Y[,1], 2]
names(var_Y) <- "activity"
names(subj) <- "subject"
cleaned <- cbind(subj, var_Y, var_X)
write.table(cleaned, "merged_clean_data.txt")

# new data set

uniqueSubjects = unique(subj)[,1]
numSubjects = length(unique(subj)[,1])
numActivities = length(activities[,1])
numCols = dim(cleaned)[2]
result = cleaned[1:(numSubjects*numActivities), ]

#means for each column
row = 1
for (s in 1:numSubjects) {
  for (a in 1:numActivities) {
    result[row, 1] = uniqueSubjects[s]
    result[row, 2] = activities[a, 2]
    tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
    result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
write.table(result, row.name=FALSE, "tidy_data_averages.txt")
