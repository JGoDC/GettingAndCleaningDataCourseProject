---
title: CodeBook.md
author: J Go
date: 11/22/15
course: Getting and Cleaning Data, Johns Hopkins University, Bloomberg School of Public Health via Coursera
---

## Project Description

I. Project assignment:

The purpose of this project is to demonstrate your ability to collect, work 
with, and clean a data set. 

The goal is to prepare tidy data that can be used for later analysis. You will 
be graded by your peers on a series of yes/no questions related to the project. 

You will be required to submit: 

1) a tidy data set as described below, 

2) a link to a Github repository with your script for performing the analysis, and 

3) a code book that describes the variables, the data, and any transformations 
or work that you performed to clean up the data called CodeBook.md. 

Descriptive information on project data

One of the most exciting areas in all of data science right now is wearable 
computing - see for example this article . Companies like Fitbit, Nike, and 
Jawbone Up are racing to develop the most advanced algorithms to attract new 
users. The data linked to from the course website represent data collected from 
the accelerometers from the Samsung Galaxy S smartphone. A full description is 
available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Human Activity Recognition Using Smartphones Data Set 
Download: Data Folder, Data Set Description

Abstract: Human Activity Recognition database built from the recordings of 30 
subjects performing activities of daily living (ADL) while carrying a waist-
mounted smartphone with embedded inertial sensors.

Data Set Characteristics:  Multivariate, Time-Series, Number of Instances: 10299, 
Area: Computer Attribute Characteristics: N/A, Number of Attributes: 561, Date Donated 2012-12-10

## Study design and data processing

According to Hadley Wickham in the dplyr vignette,

"There are three main tasks in any data analysis:

1. Figuring out what you want to do.

2. Turning a vague goal into a precise set of tasks (i.e. programming).

3. Actually crunching the numbers."

I applied the above three axioms as follows

1. Figuring out what you want to do.

1.A.   Understand the course project.

1.A.1. Read the project instructions.

1.A.2. Read the information on the course project data website.

1.B.   Download the the course project data.

1.C.   Understand the data associated with the course project.

1.C.1. Read the descriptive project data files:
	README.txt
	features_info.txt

1.C.2. Read the project data into R and examine.

1.D.   Choose the set of R tools to work with based on initial understanding
       of the data and the problem and initial examination of the data:
	dplyr, tidyr, etc

1.E.   Implement the steps required by the project specification one at a time
       in the script run_analysis.R

2. Turning a vague goal into a precise set of tasks (i.e. programming).

2.A.   Start building the script run_analysis.R by creating a file for the 
       script containing comments with the descriptions of the five steps
       required by the project.

2.B.   Determinine how to implement each step:
	1) Merges the training and the test sets to create one data set.
	   a. concatenate the subject test and train data.frames
	2) Extracts only the measurements on the mean and standard deviation 
	   for each measurement.
	3) Uses descriptive activity names to name the activities in the data 
	   set
	4) Appropriately labels the data set with descriptive variable names.
	5) From the data set in step 4, creates a second, independent tidy data 
	   set with the average of each variable for each activity and each 
	   subject.

3. Actually crunching the numbers. 

   Comines the above steps into run_analysis.R

###Collection of the raw data / Cleaning of the data

Description of how the data was collected.

Data for the project were downloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The downloaded filed was unzipped resulting in the directory structure shown
below.  Please note that all file dates containing the year 2012 arose from the
downloaded zip file.  

drwxr-xr-x@   9 j  staff      306 Oct 19 20:47 UCI_HAR_Dataset
total 64
-rwxr-xr-x@ 1 j  staff     80 Oct 10  2012 activity_labels.txt
-rwxr-xr-x@ 1 j  staff  15785 Oct 11  2012 features.txt
-rwxr-xr-x@ 1 j  staff   2809 Oct 15  2012 features_info.txt
drwxr-xr-x@ 6 j  staff    204 Nov 29  2012 test
drwxr-xr-x@ 6 j  staff    204 Nov 29  2012 train
-rwxr-xr-x@ 1 j  staff   4453 Dec 10  2012 README.txt		# further details about files

UCI_HAR_Dataset/test:
-rwxr-xr-x@  1 j  staff      5894 Nov 29  2012 y_test.txt
-rwxr-xr-x@  1 j  staff      7934 Nov 29  2012 subject_test.txt
-rwxr-xr-x@  1 j  staff  26458166 Nov 29  2012 X_test.txt
drwxr-xr-x@ 11 j  staff       374 Nov 29  2012 Inertial Signals

UCI_HAR_Dataset/train:
-rwxr-xr-x@  1 j  staff     14704 Nov 29  2012 y_train.txt
-rwxr-xr-x@  1 j  staff     20152 Nov 29  2012 subject_train.txt
-rwxr-xr-x@  1 j  staff  66006256 Nov 29  2012 X_train.txt
drwxr-xr-x@ 11 j  staff       374 Nov 29  2012 Inertial Signals

Setting aside Inertial Signals for now 
Did not revisit these files since they did not contain mean and std info

UCI_HAR_Dataset/test/Inertial Signals

UCI_HAR_Dataset/train/Inertial Signals

B. Read data from laptop into R

setwd("./UCI_HAR_Dataset/")
activity_labels <- read.table("./activity_labels.txt")
features <- read.table("./features.txt")

ytrain <- read.table("./train/y_train.txt")
xtrain <- read.table("./train/X_train.txt")
subjtrain <- read.table("./train/subject_train.txt")

ytest <- read.table("./test/y_test.txt")
xtest <- read.table("./test/X_test.txt")
subjtest <- read.table("./test/subject_test.txt")

###Notes on the original (raw) data 
Some additional notes (if avaialble, otherwise you can leave this section out).

Number of Instances: 10299, 

C.  Look at raw data

From the Abstract in the web site providing the raw data know that there are:

Number of subjects: 30
Number of Instances: 10299
Number of Attributes: 561, 
Number of recorded activities: 6 

So expect to see these numbers reflected in the raw data, which we do as is
summarized here and explained in detail in C.1 - C.n.

Number of subjects: 30 == unique elements in subjtest and subjtrain
Number of Instances: 10299 == combined number of elements in subjtest and subjtrain
Number of Instances: 10299 == combined number of observations in xtest and xtrain
Number of Attributes: 561 == number of features in features
Number of Attributes: 561 == number of variables in xtest and xtrain (V1 - V561)
Number of recorded activities: 6 == number of labels in activity_labels
Number of recorded activities: 6 == number of unique elements in combined ytest and ytrain

C.1 Check data dimensions, for how to fit train and test data together
    for the merge step:

  "activity_labels" - [1] 6 2

  "features"        - [1] 561   2

  "xtrain"          - [1] 7352  561
  "ytrain"          - [1] 7352    1

  "xtest"           - [1] 2947  561
  "ytest"           - [1] 2947    1

  "subjtrain"       - [1] 7352    1
  "subjtest"        - [1] 2947    1

  See that the:
        dimensions of subjtest match ytest
        dimensions of subjtrain match ytrain

C.2 Check the structure of data frames particularly xtrain and xtrain since more complex:

>  str(activity_labels)
'data.frame':	6 obs. of  2 variables:
 $ V1: int  1 2 3 4 5 6
 $ V2: Factor w/ 6 levels "LAYING","SITTING",..: 4 6 5 2 3 1

> str(features)
'data.frame':	561 obs. of  2 variables:
 $ V1: int  1 2 3 4 5 6 7 8 9 10 ...
 $ V2: Factor w/ 477 levels "angle(tBodyAccJerkMean),gravityMean)",..: 243 244 245 250 251 252 237 238 239 240 ..

> str(xtrain)
'data.frame':	7352 obs. of  561 variables:

> str(xtest)
'data.frame':	2947 obs. of  561 variables:
 $ V1  : num  0.257 0.286 0.275 0.27 0.275 ...

>  str(ytrain)
'data.frame':	7352 obs. of  1 variable:
 $ V1: int  5 5 5 5 5 5 5 5 5 5 ...

> str(subjtest)
'data.frame':	2947 obs. of  1 variable:
 $ V1: int  2 2 2 2 2 2 2 2 2 2 ...


C.3 Look at total and unique subjects for train and test subject data objects:

    total entries in subtrain and subtest correspond to the 10299 instances

> length(c(subjtest$V1,subjtrain$V1))	# corresponds to 10299 instances in study
[1] 10299

    unique entries in subtrain and subtest and shown to correspond to the 30 test subjects:

> unique(subjtrain$V1)
 [1]  1  3  5  6  7  8 11 14 15 16 17 19 21 22 23 25 26 27 28 29 30
> unique(subjtest$V1)
[1]  2  4  9 10 12 13 18 20 24
> length(c(unique(subjtest$V1),unique(subjtrain$V1)))	# corresponds to 30 subjects in study
[1] 30

C.4 Look at total and unique counts for ytrain and ytest:
							# total
> length(c(ytest$V1,ytrain$V1)) 			# corresponds to 10299 instances in study
[1] 10299
> 

> unique(c(ytest$V1,ytrain$V1))				# corresponds to 6 activities in study
[1] 5 4 6 1 3 2
> length(unique(c(ytest$V1,ytrain$V1)))
[1] 6
>

C.5 Look at activities:

> as.vector(activity_labels$V2)
[1] "WALKING"            "WALKING_UPSTAIRS"   "WALKING_DOWNSTAIRS"
[4] "SITTING"            "STANDING"           "LAYING"
> activity_vec <- as.vector(activity_labels$V2)
> length(activity_vec)
[1] 6

C.6 Look at features:

"features"          - [1] 561   2

  V1                V2
  1 tBodyAcc-mean()-X                           # t=time domain
  2 tBodyAcc-mean()-Y                           # X,Y,Z = triaxial, X, Y, and Z
  3 tBodyAcc-mean()-Z                           # acc = acceleration, mean
265 tBodyGyroJerkMag-arCoeff()4
266 fBodyAcc-mean()-X                           # f=frequency domain
555 angle(tBodyAccMean,gravity)                 # t=time domain
556 angle(tBodyAccJerkMean),gravityMean)
557 angle(tBodyGyroMean,gravityMean)
558 angle(tBodyGyroJerkMean,gravityMean)
559 angle(X,gravityMean)
560 angle(Y,gravityMean)
561 angle(Z,gravityMean)
...

##Creating the merged datafile

Based on the dimensional and structural analysis in the preceeding section it 
is now apparent that the way to merge the data is as follows.

Merge subjtest and subjtrain into subjmerge by concatenating data.frames
subjmerge <- as.data.frame(unlist(combine(subjtest, subjtrain)))

Merge y_test and y_train into y_merge by concaenating data.frames
ymerge <- as.data.frame(unlist(combine(ytest, ytrain)))

Merge X_test and X_train into X_merge using bind_rows from dplyr
xmerge <- bind_rows(xtest, xtrain)

Merge subjmerge, ymerge, xmerge into a single dataset using bind_cols from dplyr:
bind_cols(subjmerge, ymerge, xmerge)

merge_x_subj_y <- bind_cols(subjmerge, ymerge, xmerge)

## 2) Extracts only the measurements on the mean and standard deviation for each measurement. 

see features_info.txt
  verified that these values were correct
 grep -i mean features.txt | wc -l
       53
 tbl_df(features) %>% filter(grepl("std", V2)) 
 Source: local data frame [33 x 2]
 
 grep -i std features.txt | wc -l
       33
 
 head(features)	# NB: features are not unique, col names must be unique, so can't apply features to col names
   V1                V2	# in fully merged data set
 1  1 tBodyAcc-mean()-X
 2  2 tBodyAcc-mean()-Y
 ...
 dim(features)
 [1] 561   2

create mean_std_indexes to be able to 

select measurement on the mean and std for each measurement:

mean_std_indx_tbl_df <- tbl_df(features) %>% filter(grepl("[Mm]ean|std", V2)) %>% select(V1)  # 

index on substr

length(mean_std_indx_tbl_df$V1)
[1] 86

mean_std_indexes <- as.vector(mean_std_indx_tbl_df$V1)

extract_dataset <- merge_x_subj_y %>% select(mean_std_indexes)  # NB does not have subj and act

extract mean/std as above and combing subj and act afterwords using col_bind again 

num_xcols <- as.numeric(dim(xmerge)[2])

num_xcols
[1] 561
subj_col_num <- num_xcols + 1

act_col_num <- num_xcols + 2

extract_dataset <- merge_x_subj_y %>% select(c(mean_std_indexes, subj_col_num, act_col_num))


3) Uses descriptive activity names to name the activities in the data set
need to translate 1:6 to activities:

first <- as.numeric(extract_dataset$act)		# fully merged dataset will be best here
second <- as.vector(activity_labels$V2)
for (i in 1:length(first))
{
  # x = as.numeric(first[i])
  x = as.numeric(first[i])
  # cat(sprintf("x is: '%s'\n", x))
  # y = as.character(second[x])
  y = (second[x])
  # cat(sprintf("y is: '%s'\n", y))
  first[i] = y
}
extract_dataset$act <- first

source('~/coursera/r/UCI_HAR_Dataset/test/go.R')
first   # to show result

4) Appropriately labels the data set with descriptive variable names. 

need to translate V1:V561 to features ~ very simple: but can't use b/c are duplicates & can't have duplctd col names

colnames(df) <- features$V2	

but this should work

colnames(extract_dataset) <- c(as.character(mean_std_features), "subj", "act")
mean_std_features <- features$V2[mean_std_indx]
colnames(extract_dataset) <- c(subj", "act", as.character(mean_std_features))

###Guide to create the tidy data file

##Creating the tidy datafile
5) From the data set in step 4, creates a second, independent tidy data set with 
the average of each variable for each activity and each subject.

Use group_by from tidyr to arrange data by subject and activity

extract_dataset %>% group_by(subj,act)
Source: local data frame [10,299 x 88]
Groups: subj, act [180]

    subj      act   mean_tBodyAcc_mean_X     mean_tBodyAcc_mean_Y     mean_tBodyAcc_mean_Z            mean_tBodyAcc_std_X
   (int)    (chr)             (dbl)             (dbl)             (dbl)            (dbl)
1      2 STANDING         0.2571778       -0.02328523       -0.01465376       -0.9384040
2      2 STANDING         0.2860267       -0.01316336       -0.11908252       -0.9754147

Use summarize_each, mean, SetNames and Paste0 aggregate group_by data, take mean of each variable, and prepend mean to each variable name to create tidy dataset

tidy_dataset <- tstdf %>% summarize_each(funs(mean)) %>% setNames(c(names(.)[1], names(.)[2], paste0("mean_", names(.)[3:88])))


### Description of the variables in the tiny_data.txt file

## Dimensions of the dataset

The tidy_dataset has 180 rows which are observations of the 30 subjects performing each of the 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

eatures for which contain the string "std" or "mean" for which contain the string "std" or "mean" (case insensitive)

The tidy dataset has 88 columns: subject (1-30), activity (each of the six activities for each subject, and 86 columns for the mean of the aggregate of the 86 measurement features taken for each subject perfoming each activity. 

## Summary of the data in the tidy_dataset

The subjects number 1 to 30 for each of 30 subjects

The measurement features as found in the raw data were normalized and bounded within the range of -1 to 1, and thus have no units.  (To be clear, this is how they existed in the raw data.)    

The mean

## Variables present in the dataset

subj = subjects are 1 to 30 

act = activities WALKING and others mentioned right above 

mean_ prefix = mean of aggregated measurement feature for subject-activity, and applies to variables 3 to 88

other abbreviations in variable names include

t = time, Acc = acceleration, X,Y,Z are each an axis

std is standard deviation, gyro is gryroscope

Further details on these variables seems to require subject matter knowledge to fully understand, and further details are provided on the web site for the Human Activity Recognition Using Smartphones Data Set mentioned in Sources below

colnames(tidy_dataset)

 [1] "subj"                                   
 [2] "act"                                   
 [3] "mean_tBodyAcc_mean_X"   
 [4] "mean_tBodyAcc_mean_Y"   
 [5] "mean_tBodyAcc_mean_Z"   
 [6] "mean_tBodyAcc_std_X"     
 [7] "mean_tBodyAcc_std_Y"    
 [8] "mean_tBodyAcc_std_Z"                     
 [9] "mean_tGravityAcc_mean_X"                 
[10] "mean_tGravityAcc_mean_Y"                 
[11] "mean_tGravityAcc_mean_Z"                 
[12] "mean_tGravityAcc_std_X"                  
[13] "mean_tGravityAcc_std_Y"                  
[14] "mean_tGravityAcc_std_Z"                  
[15] "mean_tBodyAccJerk_mean_X"                
[16] "mean_tBodyAccJerk_mean_Y"                
[17] "mean_tBodyAccJerk_mean_Z"                
[18] "mean_tBodyAccJerk_std_X"                 
[19] "mean_tBodyAccJerk_std_Y"                 
[20] "mean_tBodyAccJerk_std_Z"                 
[21] "mean_tBodyGyro_mean_X"                   
[22] "mean_tBodyGyro_mean_Y"                   
[23] "mean_tBodyGyro_mean_Z"                   
[24] "mean_tBodyGyro_std_X"                    
[25] "mean_tBodyGyro_std_Y"                    
[26] "mean_tBodyGyro_std_Z"                    
[27] "mean_tBodyGyroJerk_mean_X"               
[28] "mean_tBodyGyroJerk_mean_Y"               
[29] "mean_tBodyGyroJerk_mean_Z"               
[30] "mean_tBodyGyroJerk_std_X"                
[31] "mean_tBodyGyroJerk_std_Y"                
[32] "mean_tBodyGyroJerk_std_Z"                
[33] "mean_tBodyAccMag_mean"                   
[34] "mean_tBodyAccMag_std"                    
[35] "mean_tGravityAccMag_mean"                
[36] "mean_tGravityAccMag_std"                 
[37] "mean_tBodyAccJerkMag_mean"               
[38] "mean_tBodyAccJerkMag_std"                
[39] "mean_tBodyGyroMag_mean"                  
[40] "mean_tBodyGyroMag_std"                   
[41] "mean_tBodyGyroJerkMag_mean"              
[42] "mean_tBodyGyroJerkMag_std"               
[43] "mean_fBodyAcc_mean_X"                    
[44] "mean_fBodyAcc_mean_Y"                    
[45] "mean_fBodyAcc_mean_Z"                    
[46] "mean_fBodyAcc_std_X"                     
[47] "mean_fBodyAcc_std_Y"                     
[48] "mean_fBodyAcc_std_Z"                     
[49] "mean_fBodyAcc_meanFreq_X"                
[50] "mean_fBodyAcc_meanFreq_Y"                
[51] "mean_fBodyAcc_meanFreq_Z"                
[52] "mean_fBodyAccJerk_mean_X"                
[53] "mean_fBodyAccJerk_mean_Y"                
[54] "mean_fBodyAccJerk_mean_Z"                
[55] "mean_fBodyAccJerk_std_X"                 
[56] "mean_fBodyAccJerk_std_Y"                 
[57] "mean_fBodyAccJerk_std_Z"                 
[58] "mean_fBodyAccJerk_meanFreq_X"            
[59] "mean_fBodyAccJerk_meanFreq_Y"            
[60] "mean_fBodyAccJerk_meanFreq_Z"            
[61] "mean_fBodyGyro_mean_X"                   
[62] "mean_fBodyGyro_mean_Y"                   
[63] "mean_fBodyGyro_mean_Z"                   
[64] "mean_fBodyGyro_std_X"                    
[65] "mean_fBodyGyro_std_Y"                    
[66] "mean_fBodyGyro_std_Z"                    
[67] "mean_fBodyGyro_meanFreq_X"               
[68] "mean_fBodyGyro_meanFreq_Y"               
[69] "mean_fBodyGyro_meanFreq_Z"               
[70] "mean_fBodyAccMag_mean"                   
[71] "mean_fBodyAccMag_std"                    
[72] "mean_fBodyAccMag_meanFreq"               
[73] "mean_fBodyBodyAccJerkMag_mean"           
[74] "mean_fBodyBodyAccJerkMag_std"            
[75] "mean_fBodyBodyAccJerkMag_meanFreq"       
[76] "mean_fBodyBodyGyroMag_mean"              
[77] "mean_fBodyBodyGyroMag_std"               
[78] "mean_fBodyBodyGyroMag_meanFreq"          
[79] "mean_fBodyBodyGyroJerkMag_mean"          
[80] "mean_fBodyBodyGyroJerkMag_std"           
[81] "mean_fBodyBodyGyroJerkMag_meanFreq"      
[82] "mean_angle_tBodyAccMean_gravity"         
[83] "mean_angle_tBodyAccJerkMean_gravityMean" 
[84] "mean_angle_tBodyGyroMean_gravityMean"    
[85] "mean_angle_tBodyGyroJerkMean_gravityMean"
[86] "mean_angle_X_gravityMean"                
[87] "mean_angle_Y_gravityMean"                
[88] "mean_angle_Z_gravityMean"

##Sources

reference for creating .md files:
https://guides.github.com/features/mastering-markdown/

Human Activity Recognition Using Smartphones Data Set web site for data for course project:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Hadley Wickham on tidying data paper
http://vita.had.co.nz/papers/tidy-data.pdf

Hadley Wickham's "dplyr" tutorial at useR 2014 (1/2)
https://www.youtube.com/watch?v=8SGif63VW6E

Hadley Wickham's "dplyr" tutorial at useR 2014 (2/2)
https://www.youtube.com/watch?v=Ue08LVuk790

Hadley Wickham Express yourself in R
https://www.youtube.com/watch?v=wki0BqlztCo    

codebook template:
https://gist.github.com/JorisSchut/dbc1fc0402f28cad9b41

notes on the project and the course:

https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/

http://datasciencespecialization.github.io/getclean/

Miscellaneous sources 

stackexchange for details on a variety of R topics

Getting and Cleaning Data Course course forum for a variety of information on the project, R and getting and cleaning data
