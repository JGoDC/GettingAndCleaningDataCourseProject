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

Data Set Characteristics:  Multivariate, Time-Series, 
Number of Instances: 

Number of Instances: 10299, 
Area: Computer Attribute Characteristics: N/A, 
Number of Attributes: 561, 
Date Donated 2012-12-10

## Study design and data processing

According to Hadley Wickham in the dplyr vignette,

"There are three main tasks in any data analysis:

1. Figuring out what you want to do.
2. Turning a vague goal into a precise set of tasks (i.e. programming).
3. Actually crunching the numbers."


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
	dplyr
	tidyr
	etc

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

# create and concatenate subject test and train data.frames:

subjmerge <- as.data.frame(unlist(combine(subjtest, subjtrain)))
colnames(subjmerge) <- "V1"     # to get standard V1 name of data.frame









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
