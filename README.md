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

### Step 1.  Look at project specifications and web site containing project data:

From the Abstract on the web site providing the raw data -- the following
numbers seem to be key to understanding the data:

* Number of subjects: 30
* Number of Instances: 10299
* Number of Attributes: 561
* Number of recorded activities: 6

### Step 2.  Look at raw data

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

Check the structure of the objects now containing the raw data:

str(activity_labels)
'data.frame':   6 obs. of  2 variables

str(features)
'data.frame':   561 obs. of  2 variables

str(xtrain)
'data.frame':   7352 obs. of  561 variables

str(ytrain)
'data.frame':   7352 obs. of  1 variable

str(xtest)
'data.frame':   2947 obs. of  561 variables

str(xtest)
'data.frame':   2947 obs. of  561 variables

