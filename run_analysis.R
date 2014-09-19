# Read the features and name the columns appropiately.
features.data <- read.table("features.txt")
colnames(features.data) <- c("id", "name")

# Get the mean and std column #s.
features.data.meanStd.cols <- grep("(mean|std)\\(", features.data$name)

# Read the activity labels data set and name the columns appropiately.
activity.data <- read.table("activity_labels.txt")
colnames(activity.data) <- c("id", "name")

# Read the train and test data sets.
x.train.data <- read.table("train/X_train.txt")
x.test.data <- read.table("test/X_test.txt")
y.train.data <- read.table("train/y_train.txt")
y.test.data <- read.table("test/y_test.txt")
subject.train.data <- read.table("train/subject_train.txt")
subject.test.data <- read.table("test/subject_test.txt")

# Combine the train and test data sets.
x.data <- rbind(x.train.data, x.test.data)
y.data <- rbind(y.train.data, y.test.data)
subject.data <- rbind(subject.train.data, subject.test.data)

# Subset x.data to only have cols with mean/std.
x.data.meanStd <- x.data[, features.data.meanStd.cols]

# Rename the x.data columns to the corresponding names
colnames(x.data.meanStd) <- as.vector(features.data[features.data.meanStd.cols,2])

# Get the total number of mean/std columns.
numColsMeanStd <- length(features.data.meanStd.cols)

# Replace the y.data activity id with the corresponding activity name.
y.data[,1] <- activity.data[y.data[,1],2]

# Combine the x.data, y.data and subject.data sets.
all.data <- cbind(x.data.meanStd, y.data, subject.data)
colnames(all.data)[numColsMeanStd + 1] <- "Activity"
colnames(all.data)[numColsMeanStd + 2] <- "Subject"

# Perform Split-Apply-Combine strategy to get mean per Subject per Activity to create tidy data set.
pieces<- split(all.data, list(all.data$Activity, all.data$Subject))
results <- vector("list", length(pieces))
for (i in seq_along(pieces)) {
  piece <- pieces[[i]]
  meanStd <- colMeans(piece[, 1:66])
  activitySubject <- list(piece$Activity[[1]], piece$Subject[[1]])
  results[[i]] <- c(meanStd, as.character(activitySubject[[1]]), as.character(activitySubject[[2]]))
}
result <- do.call("rbind", results)

# Write tidy data set to file.
write.table(x=result, row.name=FALSE, file="tidy_data.txt", col.names = FALSE, quote = FALSE)