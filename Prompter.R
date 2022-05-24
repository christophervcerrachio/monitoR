source("Fetcher.R");
#########################################################################################
prompter <- function(df){
    categoryIDVector <- df$ID;
    if(length(categoryIDVector) == 0){
        cat("No children categories of selected category\n");
        cat("Would you like to see the series of this category? [y/n]: ");
        userInputConfirm <- readLines("stdin", n=1);
        if(userInputConfirm == "y"){
            responseDFTemp <- fetcherCategorySeries(userInput);
            if(length(responseDFTemp$seriess) != 0){





                print(responseDFTemp, row.names=FALSE);
                prompterSeries(responseDF);





            }else{
                cat("No series for this category, choose another\n");
                print(responseDF, row.names=FALSE);
                prompter(responseDF);
            }
        }else{
            cat("Going back to initial categories...\n");
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
#########################################################################################
    cat("\n");
    cat("Would you like to see the series of this category? [y/n]: ");
    userInputConfirm <- readLines("stdin", n=1);
    if(userInputConfirm == "y"){
        responseDFTemp <- fetcherCategorySeries(userInput);
        if(is.double(responseDFTemp) != TRUE){





            print(responseDFTemp, row.names=FALSE);
            prompterSeries(responseDFTemp);




            
        }else{
            cat("\nNo series for this category, choose another\n");
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
            cat("Going back to initial categories...\n");
            responseDF <- fetcherRoot();
            print(responseDF, row.names=FALSE);
            prompter(responseDF);
        }
    }
}
#########################################################################################
prompterSeries <- function(df){



}
