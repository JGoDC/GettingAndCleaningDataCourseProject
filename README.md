---
title: READMD.md
author: J Go 
date: 11/21/15
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

Number of subjects: 30 == unique elements in subjtest and subjtrain
Number of Instances: 10299 == combined number of elements in subjtest and subjtrain
Number of Instances: 10299 == combined number of observations in xtest and xtrain
Number of Attributes: 561 == number of features in features
Number of Attributes: 561 == number of variables in xtest and xtrain (V1 - V561)
Number of recorded activities: 6 == number of labels in activity_labels
Number of recorded activities: 6 == number of unique elements in combined ytest
and ytrain
Dimensions of subjtest match ytest
Dimensions of subjtrain match ytrain

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



