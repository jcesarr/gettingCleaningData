gettingCleaningData
===================

Coursera Data Science course on Getting and Cleaning Data

This project contains the R script (run_analysis.R) that creates a tidy data set data collected from accelerometers from the Samsung Galaxy S smartphone.

A full description is located at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data is located at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

In order to run the script and produce a tiny data set:
1. Unzip the compressed dataset file.
2. Put the run_analysis.R file inside the main folder (UCI HAR Dataset)
3. Run the run_analysis.R file, which will create a tidy_data.txt file

The produced data set contains the mean value of the columns that correspond to the mean and standard deviation per activity per user.

The run_analysis.R script reads the data for the corresponding train and test data sets and combine them together.
It also replaces the ids of the given activities with the corresponding names.
It also combines the subject ids to the data set.

The script also selects only those columns that correspond to mean and standard deviation.

In order to create a tidy data set, the script applies the Split-Apply-Combine pattern to the data set.

The script splits the data by activity per user, calculates the mean for each group and then combines the groups to create the tidy data set.

At the end the script creates a text file called "tidy_data.txt"
