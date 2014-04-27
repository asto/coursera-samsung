###Introduction

run_analysis.R does the following with the Samsung dataset available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones:
	* Combines the "test" and "train" data
	* Retains just std() and mean() columns and removes the rest
	* Adds in the subject and activity info
	* Adds headers
	* Writes the cleaned info to a tab separated txt file called Output.txt
	* Writes means by subject and activity to Means.txt

*Existing output files WILL BE OVER-WRITTEN WITHOUT WARNING*

###How it works

* prepTable is a function that takes a data filename, an activity filename and a subject filename and puts them all together. It also removes columns that aren't mean() or std()
* Labels are added from the activity\_labels.txt file
* Both test and train data are combined to form the "testData" dataframe
* The meansData data frame contains means by subject and activity. The first column "Labels" has the subject and activity name. Ex: 2-WALKING. The remaining columns are averages for that subject and activity
* testData is written to Output.txt and meansData is written to Means.txt. Both are tab seperated value lists


