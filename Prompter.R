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
        if(is.double(responseDFTemp) != TRUE){





            print(responseDFTemp, row.names=FALSE);
            prompterSeries(responseDFTemp);





        }else{
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
#look at api docs for possibilities with data
#can get observational data (time series)
#prompt user to select series id
  #validate input with prior code
    #write fetcherSeriesSeries function to request time series data
      #format appropriately for presentation/further use (visualization, etc.)
        #present data options with prompterSeriesData function
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




        #NEED TO CHECK FOR -1 RESPONSE FROM fetcherSeriesSeries FUNCTION
        responseDFTemp<- fetcherSeriesSeries(userInput);
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





}
