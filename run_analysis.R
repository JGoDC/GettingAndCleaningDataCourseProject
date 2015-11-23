# run_analysis.R
# 
# You should create one R script called run_analysis.R that does the following.
# 
# 1) Merges the training and the test sets to create one data set. ~ ok
# 
# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
# 
# 3) Uses descriptive activity names to name the activities in the data set
# 
# 4) Appropriately labels the data set with descriptive variable names.
# 
# 5) From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
# 
# tidy_data_set <- 
# 
# write.table(tidy_data_set, file = "tidy_data_set.txt", row.names = FALSE)
#
# Please upload the tidy data set created in step 5 of the instructions. Please
# upload your data set as a txt file created with write.table() using
# row.name=FALSE (do not cut and paste a dataset directly into the text box, as
# this may cause errors saving your submission).


## 1)  Merges the training and the test sets to create one data set.
##
## 1A) Read the training and test data sets into R
setwd("./UCI_HAR_Dataset/")		# may want to avoid changing dir
working_dir <- getwd()
cat(sprintf("Changing current working directory to: '%s'\n", working_dir))

cat("\nReading activity_labels:\n ")	# extra space here lines up output
activity_labels <- read.table("./activity_labels.txt")
cat(sprintf("%s\n", activity_labels$V2))

cat("\nReading features:\n")
features <- read.table("./features.txt")
first_ten_features <- head(features)
cat("First ten features are:\n ")
cat(sprintf("'%s'\n", first_ten_features$V2))

cat("\nReading subject_test...\n")
xtest <- read.table("./test/X_test.txt")
ytest <- read.table("./test/y_test.txt")
subjtest <- read.table("./test/subject_test.txt")

cat("Reading subject_train...\n")
xtrain <- read.table("./train/X_train.txt")
ytrain <- read.table("./train/y_train.txt")
subjtrain <- read.table("./train/subject_train.txt")
setwd("..")

## 1B) Merge subjtest and subjtrain into subjmerge by concatenatiion of data.frames:
cat("\nMerging subject_test and subject_train int subject_merge\n")
# subjmerge <- as.data.frame(unlist(combine(subjtest, subjtrain))) # base R version
subjmerge <- bind_rows(subjtest, subjtrain)			   # dplyr version
colnames(subjmerge) <- "sub"     # to get name of data.frame
unique_subjects <- unique(subjmerge$sub)
num_subjects <- length(unique_subjects)
cat(sprintf("Found '%s' unique subjects which are:\n ", num_subjects))
cat(sprintf("'%s'\n", unique_subjects))

## 1C) Merge activities in y_test and y_train into activity_merge by bind_rows:
cat("\nMerging activities in y_test and y_train into activity_merge\n")
act_merge <- bind_rows(ytest, ytrain)
colnames(act_merge) <- "act"     # to represent activities
unique_act_merge <- unique(act_merge$act)
num_act_merge <- length(unique_act_merge)
cat(sprintf("Found '%s' unique elements in act_merge which are:\n ", num_act_merge))
cat(sprintf("'%s'\n", unique_act_merge))

## 1D) Merge X_test and X_train into measurement_merge:
cat("\nMerging x_test and x_train into measurement_merge\n")
measurement_merge <- bind_rows(xtest, xtrain)
measurement_merge_rows <- dim(measurement_merge)[1]
measurement_merge_cols <- dim(measurement_merge)[2]
cat(sprintf("Showing number of rows in measurement_merge is 10299 as expected: '%s'\n", measurement_merge_rows))
cat(sprintf("Showing number of cols in measurement_merge is 561 as expected: '%s'\n", measurement_merge_cols))

## 1E) Merge subj_merge, act_merge and measurement_merge into single dataset using bind_cols:
cat("\nMerging subject_merge, act_merge and measurement_merge into merge_subj_act_measurement\n")

merge_subj_act_measurement <- bind_cols(subjmerge, act_merge, measurement_merge)

merge_subj_act_measurement_rows <- dim(merge_subj_act_measurement)[1]
merge_subj_act_measurement_cols <- dim(merge_subj_act_measurement)[2]

cat(sprintf("Showing number of rows in merge_subj_act_measurement is 10299 as expected: '%s'\n", merge_subj_act_measurement_rows))
cat(sprintf("Showing number of cols in merge_subj_act_measurement is 563 as expected: '%s'\n", merge_subj_act_measurement_cols))

# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
# 
cat("\nExtracting subject, act and only mean and stdmeasurements from merge_subj_act_measurement\n")

## create index to extract only mean and standard deviation measurements from 
## merged dataset using dplyr
cat("\nCreating index for extracting subject, act and only mean and stdmeasurements from merged dataset\n")
mean_std_indx_df <- tbl_df(features) %>% filter(grepl("[Mm]ean|std", V2)) %>% select(V1)

subj_col_num <- 1			# subject is in column 1 of merged dataset
act_col_num <- 2			# activity is in column 2 of merged dataset
mean_std_indx <- mean_std_indx_df$V1
mean_std_indx2 <- mean_std_indx + 2  	# add offset of two since first two columns are subj and act

extract_dataset <- merge_subj_act_measurement %>% select(c(subj_col_num, act_col_num, as.numeric(mean_std_indx2)))

extract_dataset_rows <- dim(extract_dataset)[1]
extract_dataset_cols <- dim(extract_dataset)[2]

cat(sprintf("Showing number of rows in extract_dataset is 10299 as expected: '%s'\n", extract_dataset_rows))
cat(sprintf("Showing number of cols in extract_dataset is 88 as expected: '%s'\n", extract_dataset_cols))

# 3) Uses descriptive activity names to name the activities in the data set
# 
cat("\nCreating descriptive activity names to name activities in extracted dataset\n")
# first <- as.numeric(activity_labels$V1)	# first will be the numeric activities from ymerge
first <- as.numeric(extract_dataset$act)	# first will be the numeric activities from ymerge
second <- as.vector(activity_labels$V2)
for (i in 1:length(first))
{
  x = as.numeric(first[i])
  y = (second[x])
  first[i] = y
}

# apply activity_names to extracted dataset:
extract_dataset$act <- first

first_activity_name <- head(first, 1)
last_activity_name <- tail(first, 1)
cat("First and last descriptive activity names are:\n ")
cat(sprintf("'%s'\n ", first_activity_name))
cat(sprintf("'%s'\n", last_activity_name))

# 4) Appropriately labels the data set with descriptive variable names.
# 
cat("\nCreating descriptive variable names to name for columns in extracted dataset\n")
mean_std_features <- features$V2[mean_std_indx]
# solution for tidying special character in col names
x <- make.names(mean_std_features)
y <- gsub("[\\.]", "_", x)
z <- gsub("[_][_]", "_", y)
a <- gsub("[_][_]", "_", z)
b <- gsub("[_]$", "", a)
mean_std_features <- b
colnames(extract_dataset) <- c("subj", "act", as.character(mean_std_features))

first_variable_name <- "subj"
last_variable_name <- tail(mean_std_features, 1)
cat("First and last descriptive variable names are:\n ")
cat(sprintf("'%s'\n ", first_variable_name))
cat(sprintf("'%s'\n", last_variable_name))

# 5) From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
# 
# extract_dataset %>% group_by(subj,act)
cat("\nCreating tidy dataset: tidy_dataset\n")
tstdf <- extract_dataset %>% group_by(subj, act)
tidy_dataset <- tstdf %>% summarize_each(funs(mean)) %>% setNames(c(names(.)[1], names(.)[2], paste0("mean_", names(.)[3:88])))
write.table(tidy_dataset, file="./tidy_dataset.txt", row.name=FALSE)
num_tidy_rows <- dim(tidy_dataset)[1]
num_tidy_cols <- dim(tidy_dataset)[2]
cat(sprintf("Showing number of rows in tidy_tidy_dataset is 180 as expected: '%s'\n", num_tidy_rows))
cat(sprintf("Showing number of cols in tidy_tidy_dataset is 88 as expected: '%s'\n", num_tidy_cols))
