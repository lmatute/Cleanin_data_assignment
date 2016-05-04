# The function reads data collected from a study and conducts the follwings tasks
# 1 Merges the training and test sets to create one data set
# First we read in all the required data, by logical groupings
run_analysis<- function(){
    library(dplyr)
    # we start by reading the x and y values for the test data set together with  the subject and combine it into one table
    X_test<-read.table("UCI HAR DataSet/test/X_test.txt")
    y_test<-read.table("UCI HAR DataSet/test/y_test.txt")
    s_test<-read.table("UCI HAR DataSet/test/subject_test.txt")
    testtable<-cbind(X_test,y_test,s_test)
    # Next we read the features file (defined for x ) and add the y label also and assign it to the created table
    features<-c(as.vector(read.table("UCI HAR DataSet/features.txt")[,2]),"Activity","Subject")
    names(testtable)=features
    # We add a column to identify this part of the data as test
    testtable["Partition"]="test"
    # next we read the training data set
    X_train<-read.table("UCI HAR DataSet/train/X_train.txt")
    y_train<-read.table("UCI HAR DataSet/train/y_train.txt")
    s_train<-read.table("UCI HAR DataSet/train/subject_train.txt")
    traintable<-cbind(X_train,y_train,s_train)
    names(traintable)=features
    traintable["Partition"]="train"
    # Now we join the two tables
    combinedtable<-rbind(testtable,traintable) 
    # The last part is where we mutate the activity colum to have proper labels
    actlabels<-read.table("UCI HAR DataSet/activity_labels.txt")
    combinedtable<-mutate(combinedtable,Activity=factor(Activity,labels=actlabels[,2]))
    #Cleaning the colnames for a more descriptive wording.-,f,t,,., will be handled
    varnames<-colnames(combinedtable)
    # Next we use the facility provided in dlypr for easier data handling
    combinedtable<-tbl_df(combinedtable)
    # Now we need to extract only mean and std type of measurements
    meanstdcol<-grep("mean|std|Subject|Activity",varnames,value =FALSE)  # these are the col numbers
    meanstdnames <- grep("mean|std|Subject|Activity",varnames, value = TRUE) # these are the col names
    combinedtable<-combinedtable[,meanstdcol]
    names(combinedtable)=meanstdnames
   # final step is to group the data by Subject and Activity calculating means for all variables
    ressum<-combinedtable %>% group_by(Subject,Activity) %>% summarize_each (funs(mean))
    return(ressum)
}
