# run_analysis.R combines the "test" and "train" data, adds in the subject and
# activity info and writes the cleaned info to a tab separated txt file called
# Output.txt. Also writes means by subject and activity to Means.txt
# Existing output files WILL BE OVER-WRITTEN WITHOUT WARNING

#prepTable joins the data with the subject info and activity info and also
#assigns column names
#Note: redColumns must be set before this function is called
prepTable <- function(dataFile, activityFile, subjectFile){
  testData <- read.table(dataFile)
  testData <- testData[,reqdColumns$Index]
  colnames(testData) <- reqdColumns$Column.Name
  testData <- cbind(testData, read.table(activityFile))
  colnames(testData)[67] <- "Activity"
  testData <- cbind(testData, read.table(subjectFile))
  colnames(testData)[68] <- "Subject"
  testData
}

activityLabels <- read.table("activity_labels.txt")
colnames(activityLabels) <- c("Index", "Activity")

featuresData <- read.table("features.txt", col.names=c("Index", "Column Name"))
reqdColumns <- featuresData[grepl("mean\\(\\)|std\\(\\)",featuresData$Column.Name),]

testData <- rbind(prepTable("test/X_test.txt", "test/y_test.txt", "test/subject_test.txt"),
                    prepTable("train/X_train.txt", "train/y_train.txt", "train/subject_train.txt"))

testData$Activity <- activityLabels$Activity[match(testData$Activity, activityLabels$Index)]
testData <- testData[,c(68,67,1:66)]

write.table(testData, "Output.txt", sep="\t", row.names=F)

labels <- NULL
means <- NULL
for (subject in unique(testData$Subject)){
  for (activity in activityLabels$Activity){
    labels <- c(labels, paste(subject, activity, sep="-"))
    means <- rbind(means, colMeans(testData[testData$Activity == activity & testData$Subject == subject,3:68]))
  }
}
meansData <- data.frame(Labels=labels, means)

write.table(meansData, "Means.txt", sep="\t", row.names=F)