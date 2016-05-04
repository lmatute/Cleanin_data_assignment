# Cleaning_data_assignment
Last assignment cleaning data course

The function run_analysis() is an R function that generates a tidy data set as per the last assignment in the Getting and Cleaning Data Course.

For the function to run properly, the  UCI HAR Dataset needs to be in the same working directory as where the function resides. The data can be readily downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The function is called in the following way:  run_analysis()

It will automatically download necessary packages and in the process may generate messages.

The function has comments embedded into the code that are further explained here for clarity.

To produce the output, the function needs to load different components of the data set, combine them into one larger set and then select a subset of interest follows:

1) loads the "UCI HAR DataSet/test/X_test.txt file into the X_test variabe. This holds calculations made on the underlying raw observations.
2) load the "UCI HAR DataSet/test/y_test.txt file into  the t_test variable. This holds the corresponding activities for which the observations were made
3) load the "UCI HAR DataSet/test/subject_test.txt into the s_test variable. This holds the identifiers of the subjects on which the measurements were made

4) With these three sets loaded we combine them into one table called testtable. So this table contains all the activies, subjects and measurments of the data classified as test.
5) We also capture the feature names  which are over 500 for this data set in a variable called features.

6) Although it is not a requirement, we create a new column identifying this part of the data as “test” data. While we will merge the test data with the training data it is  necessary to keep track of how the original split into test and training was done for reproducibility of results.

7) We now repeat the process described in steps 1 through six but now for the training data. We load these with different variables names as in X-train,y_train and s_train and use the corresponding files "UCI HAR DataSet/train/X_train.txt”, "UCI HAR DataSet/train/y_train.txt”,"UCI HAR DataSet/train/subject_train.txt”.
8) We combine this set into a traintable set and add a column to identify this set as “training”. (same process as with test part described above)

9) Next we combine the testtable and traintable into one dataframe called combined table. We also mutate the resulting table to handle the fact that activities are coded as numbers and we prefer the labels for clarity
10) We convert this table to the dylpr format for easier handling ( we keep the same name)
11) Next we make sure the table has proper labels on all columns
12) The assignment calls for only reporting on variables of mean and std deviation. So we create a subset of those elements by searching for the words mean and std and identify the column names and column numbers to subset the combinedtable into a smaller data set. The variable  meanstdnames holds the names of the the desired columns and the variable  meanstdcol holds the column numbers.
13) Next we create the smaller table based on point 12 and assure proper labeling of the columns
14) Finally we group by subject and activity and calculate the means of all measurements and return the output.
