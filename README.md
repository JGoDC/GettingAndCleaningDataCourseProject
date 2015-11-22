---
title: READMD.md
author: J Go 
date: 11/22/15
coures: Getting And Cleaning Data, JHU, Bloomberg School of Public Health via Coursera
---

# Getting And Cleaning Data Course Project 

## Script:

### run_analysis.R  
This script performs the steps of the project as summarized below and as 
detailed in the CodeBook.md.
The run_analysis.R script processes the project raw input data
into the final output of the project, the tidy_file

## Other Files

### CodeBook.md         
detailed explanation of the project and processing

### tidy_dataset        
final output of the project

## Explanation of how the project was solved 

### Observation 1.  Look at project specifications and web site containing project data:

From the Abstract on the web site providing the raw data -- the following
numbers seem to be key to understanding the data:

* Number of subjects: 30
* Number of Instances: 10299
* Number of Attributes: 561
* Number of recorded activities: 6

### Observation 2.  Look at raw data

Expect to see numbers from step 1 reflected in the raw data, which we do as is
summarized here and explained in detail in the Codebook.md

Read the data into the following objects and check the data dimensions, for
how to  merge train and test data together for the merge step as required by
the first step in the project requirements

  "activity_labels" - [1] 6 2

  "features"        - [1] 561   2

  "xtrain"          - [1] 7352  561
  "ytrain"          - [1] 7352    1

  "xtest"           - [1] 2947  561
  "ytest"           - [1] 2947    1

  "subjtrain"       - [1] 7352    1
  "subjtest"        - [1] 2947    1

Each object above is a data.frame

From the above numbers and some simple tests detailed in CodeBook.md we see that  

* Number of subjects: 30 == unique elements in subjtest and subjtrain
* Number of Instances: 10299 == combined number of elements in subjtest and subjtrain
* Number of Instances: 10299 == combined number of observations in xtest and xtrain
* Number of Attributes: 561 == number of features in features
* Number of Attributes: 561 == number of variables in xtest and xtrain (V1 - V561)
* Number of recorded activities: 6 == number of labels in activity_labels
* Number of recorded activities: 6 == number of unique elements in combined ytest
and ytrain
* Dimensions of subjtest match ytest
* Dimensions of subjtrain match ytrain

## Project Steps

### Project Step 1: Merge training and test datasets

Based on the dimensional and structural analysis in the preceeding section it
is now apparent that the way to merge the data is as follows

Merge subjtest and subjtrain into subjmerge by concatenating data.frames
subjmerge <- as.data.frame(unlist(combine(subjtest, subjtrain)))

Merge y_test and y_train into y_merge by concaenating data.frames
ymerge <- as.data.frame(unlist(combine(ytest, ytrain)))

Merge X_test and X_train into X_merge using bind_rows from dplyr
xmerge <- bind_rows(xtest, xtrain)

Merge subjmerge, ymerge, xmerge into a single dataset using bind_cols from dplyr:
bind_cols(subjmerge, ymerge, xmerge)

merge_x_subj_y <- bind_cols(subjmerge, ymerge, xmerge)

### Project Step 2: Extracts only the measurements on the mean and standard deviation for each measurement 

There was nothing more specific in the instructions I chose to select every variable that had one of the strings "mean" or "std"

Create object called mean_std_features using tbl_df, filter and select.  See codebook and script for further details

tbl_df(features) %>% filter(grepl("[Mm]ean|std", V2)) %>% select(V1)

### Project Step 3: Uses descriptive activity names to name the activities in the data set

Translated 1:6 to activities using the activity labels in features with a for loop

### Project Step 4: Appropriately labels the data set with descriptive variable names

Uses make.names and mean_std_features, followed by a series of gsub operations to remove speclial characters from the variable names.  Also experimented with qdap as an alternate to series of qsubs

### Project Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject 

This step is the heart of the project and combined with the knowedge of Hadley Wickham's R packages dplyr and tidyr, and the above processing steps the way forward comes into focus

Because data is needed by "each acvitity and subject" group_by(subj, act) from tidyr is used

Because there are 30 subjects and six activities this creates 180 groups

Because the same subject performs the same activities multiple times aggregation is needed

Because the mean of activities is also required at the time of the aggregation, summarize_each is used to apply the mean function

Because it is means that are being reported, the string "mean_" is prepended to the name of each feature variable using setNames to further enhance these labels

### Output of run_analysis.R to further illustrate the project solution

Liberal use was made of print statements as an aid to developement and to demonstrate the working of the program

This is the output of run_analysis.R looks like as the script is running

source('~/coursera/r/tst.R')

Changing current working directory to: '/Users/j/coursera/r/UCI_HAR_Dataset'

Reading activity_labels:
*WALKING
*WALKING_UPSTAIRS
*WALKING_DOWNSTAIRS
*SITTING
*STANDING
*LAYING

Reading features:

First ten features are:
 'tBodyAcc-mean()-X'
 'tBodyAcc-mean()-Y'
 'tBodyAcc-mean()-Z'
 'tBodyAcc-std()-X'
 'tBodyAcc-std()-Y'
 'tBodyAcc-std()-Z'

Reading subject_test...

Reading subject_train...

Merging subject_test and subject_train into subject_merge

Found '30' unique subjects as expected which are:
 '2'
 '4'
 '9'
 '10'
 '12'
 '13'
 '18'
 '20'
 '24'
 '1'
 '3'
 '5'
 '6'
 '7'
 '8'
 '11'
 '14'
 '15'
 '16'
 '17'
 '19'
 '21'
 '22'
 '23'
 '25'
 '26'
 '27'
 '28'
 '29'
 '30'

Merging activities in y_test and y_train into activity_merge

Found '6' unique elements in act_merge which are:
 '5'
 '4'
 '6'
 '1'
 '3'
 '2'

Merging x_test and x_train into measurement_merge

Showing number of rows in measurement_merge is 10299 as expected: '10299'

Showing number of cols in measurement_merge is 561 as expected: '561'

Merging subject_merge, act_merge and measurement_merge into merge_subj_act_measurement

Showing number of rows in merge_subj_act_measurement is 10299 as expected: '10299'

Showing number of cols in merge_subj_act_measurement is 563 as expected: '563'

Extracting subject, act and only mean and stdmeasurements from merge_subj_act_measurement

Creating index for extracting subject, act and only mean and stdmeasurements from merged dataset

Showing number of rows in extract_dataset is 10299 as expected: '10299'

Showing number of cols in extract_dataset is 88 as expected: '88'

Creating descriptive activity names to name activities in extracted dataset

First and last descriptive activity names are:

 'STANDING'

 'WALKING_UPSTAIRS'

Creating descriptive variable names to name for columns in extracted dataset

First and last descriptive variable names are:

 'subj'

 'angle_Z_gravityMean'

Creating tidy dataset: tidy_dataset

Showing number of rows in tidy_tidy_dataset is 180 as expected: '180'

Showing number of cols in tidy_tidy_dataset is 88 as expected: '88'

### View of first 13 rows, last 10 rows, and first five columns of the 180 by 88 tidy_dataset:

	subj	act	mean_tBodyAcc_mean_X	mean_tBodyAcc_mean_Y	mean_tBodyAcc_mean_Z

1	1	LAYING			0.2215982	-0.040513953	-0.1132036

2	1	SITTING			0.2612376	-0.001308288	-0.1045442

3	1	STANDING		0.2789176	-0.016137590	-0.1106018

4	1	WALKING			0.2773308	-0.017383819	-0.1111481

5	1	WALKING_DOWNSTAIRS	0.2891883	-0.009918505	-0.1075662

6	1	WALKING_UPSTAIRS	0.2554617	-0.023953149	-0.0973020

7	2	LAYING			0.2813734	-0.018158740	-0.1072456

8	2	SITTING			0.2770874	-0.015687994	-0.1092183

9	2	STANDING		0.2779115	-0.018420827	-0.1059085

10	2	WALKING			0.2764266	-0.018594920	-0.1055004

11	2	WALKING_DOWNSTAIRS	0.2776153	-0.022661416	-0.1168129

12	2	WALKING_UPSTAIRS	0.2471648	-0.021412113	-0.1525139

13	3	LAYING			0.2755169	-0.018955679	-0.1013005

...

171	29	STANDING		0.2779651	-0.017260587	-0.10865907

172	29	WALKING			0.2719999	-0.016291560	-0.10663243

173	29	WALKING_DOWNSTAIRS	0.2931404	-0.014941215	-0.09813400

174	29	WALKING_UPSTAIRS	0.2654231	-0.029946531	-0.11800059

175	30	LAYING			0.2810339	-0.019449410	-0.10365815

176	30	SITTING			0.2683361	-0.008047313	-0.09951545

177	30	STANDING		0.2771127	-0.017016389	-0.10875621

178	30	WALKING			0.2764068	-0.017588039	-0.09862471

179	30	WALKING_DOWNSTAIRS	0.2831906	-0.017438390	-0.09997814

180	30	WALKING_UPSTAIRS	0.2714156	-0.025331170	-0.12469749
