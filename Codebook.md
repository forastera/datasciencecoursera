## Codebook
Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R performs cleans up the source data by merging the training and the test data sets.

The file features.txt contains the measurements of mean and standard deviation. 

The file activity_labels.txt contains activity names in the data set:

walking

walkingupstairs

walkingdownstairs

sitting

standing

laying

The script also appropriately labels the data set with the labels listed above, applied label to subject id, then merges them in merged_clean_data.txt, then creates a second, independent tidy data set with the average of each measurement for each activity and each subject. The result is saved as data_set_with_the_averages.txt.
