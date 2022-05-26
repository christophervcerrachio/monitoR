source("Fetcher.R");
#########################################################################################
prompter <- function(df){
    categoryIDVector <- df$ID;
    if(length(categoryIDVector) == 0){
        cat("No children categories of selected category\n\n");
        cat("Would you like to see the series(s) of this category? [y/n]: ");
        userInputConfirm <- readLines("stdin", n=1);
        if(userInputConfirm == "y"){
            responseDFTemp <- fetcherCategorySeries(userInput);
            if(length(responseDFTemp$seriess) != 0){
                print(responseDFTemp, row.names=FALSE);
                prompterSeries(responseDF);
            }else{
                cat("No series for this category, choose another\n\n");
                print(responseDF, row.names=FALSE);
                prompter(responseDF);
            }
        }else{
            cat("Going back to initial categories\n\n");
            responseDF <- fetcherRoot();
            print(responseDF, row.names=FALSE);
            prompter(responseDF);
        }
    }
#########################################################################################
    cat("\nPlease select (type) a category id from the table\n");
    userInput <- readLines("stdin", n=1);
    userIDFlag <- FALSE;
    while(userIDFlag == FALSE){
        for(id in categoryIDVector){
            if(id == userInput){
                userIDFlag <- TRUE;
                break;
            }
        }
        if(userIDFlag == FALSE){
            cat("Not a valid category id, select again\n");
            userInput <- readLines("stdin", n=1);
        }
    }
    cat("\n");
#########################################################################################
    cat("Would you like to see the series(s) of this category? [y/n]: ");
    userInputConfirm <- readLines("stdin", n=1);
    if(userInputConfirm == "y"){
        responseDFTemp <- fetcherCategorySeries(userInput);
        #checking for -1 response from fetcherCategorySeries function
          #no series for selected category
        if(is.double(responseDFTemp) != TRUE){
            print(responseDFTemp, row.names=FALSE);
            prompterSeries(responseDFTemp);
        }else{
            #when fetcherCategorySeries function returns -1
            cat("\nNo series for this category, choose another\n\n");
            print(responseDF, row.names=FALSE);
            prompter(responseDF);
        }
    }else{
#########################################################################################
        cat("\nWould you like to see the children categories of this category? [y/n]: ");
        userInputConfirm <- readLines("stdin", n=1);
        if(userInputConfirm == "y"){
            responseDF <- fetcherChildren(userInput);
            print(responseDF, row.names=FALSE);
            prompter(responseDF);
        }else{
            cat("Going back to initial categories\n\n");
            responseDF <- fetcherRoot();
            print(responseDF, row.names=FALSE);
            prompter(responseDF);
        }
    }
}
#########################################################################################
prompterSeries <- function(df){
    seriesIDVector <- df$ID;
    cat("\nPlease select (type) a series id from the table\n");
    userInput <- readLines("stdin", n=1);
    userIDFlag <- FALSE;
    while(userIDFlag == FALSE){
        for(id in seriesIDVector){
            if(id == userInput){
                userIDFlag <- TRUE;
                break;
            }
        }
        if(userIDFlag == FALSE){
            cat("Not a valid series id, select again\n");
            userInput <- readLines("stdin", n=1);
        }
    }
    cat("\n");
#########################################################################################
    cat("Would you like to see the observational data of this series? [y/n]: ");
    userInputConfirm <- readLines("stdin", n=1);
    if(userInputConfirm == "y"){
        #even DISCONTINUED series contain time series data in response
        #fetcherSeriesSeries -1 return value might not be needed
        responseDFTemp <- fetcherSeriesSeries(userInput);
        print(responseDFTemp, row.names=FALSE);
        prompterSeriesData(responseDFTemp);
    }else{
        cat("Going back to initial categories\n\n");
        responseDF <- fetcherRoot();
        print(responseDF, row.names=FALSE);
        prompter(responseDF);
    }
}
#########################################################################################
prompterSeriesData <- function(df){
    cat("Would you like to export the observational data of this series? [y/n]: ");
    userInputConfirm <- readLines("stdin", n=1);
    if(userInputConfirm == "y"){
        #export data to local directory as a json file

    }else{
        cat("Would you like to visualize the observational data of this series? [y/n]: ");
        userInputConfirm <- readLines("stdin", n=1);
        if(userInputConfirm == "y"){
            #export data to local directory as a json file

        }else{
            cat("Going back to initial categories\n\n");
            responseDF <- fetcherRoot();
            print(responseDF, row.names=FALSE);
            prompter(responseDF);
        }
    }
}
