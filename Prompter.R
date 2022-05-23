source("Fetcher.R");


#id of all child categories
#input is DATAFRAME
prompter <- function(df){


  categoryIDVector <- df$ID;

#BASE CASE FOR RECURSIVE PROMPTS############################################
  if(length(categoryIDVector) == 0){
    #ACCOUNT FOR OPTIONS OF CATEGORY WITH ZERO CHILDREN#####################
    cat("No children categories of selected category\n");
    cat("Would you like to see the series of this category? [y/n]: ");
    userInputConfirm <- readLines("stdin", n=1);
    if(userInputConfirm == "y"){

      #SERIES SELECTION START HERE
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

        #go back to root children
        responseDF <- fetcherRoot();
        print(responseDF, row.names=FALSE);
        prompter(responseDF);

      }
    }


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
  cat("\n"); #input/output spacing

#OPTIONS FOR CATEGORY MATCHING USER INPUT###################################
  cat("Would you like to see the series of this category? [y/n]: ");
  userInputConfirm <- readLines("stdin", n=1);
  if(userInputConfirm == "y"){

    #HERE TESTING 32991 and 10
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

    cat("\nWould you like to see the children categories of this category? [y/n]: ");
    userInputConfirm <- readLines("stdin", n=1);
    if(userInputConfirm == "y"){

      #get children of selected category
      responseDF <- fetcherChildren(userInput);
      print(responseDF, row.names=FALSE);
      prompter(responseDF);

    }else{

        cat("Going back to initial categories...\n");
        #go back to root children
        responseDF <- fetcherRoot();
        print(responseDF, row.names=FALSE);
        prompter(responseDF);

    }
  }
}


#SEPARATE PROMPT PROCESS FOR SERIES SELECTION
prompterSeries <- function(df){
  cat("\nnow in prompterSeries\n");
  # seriesIDVector <- df$ID;



}
