source("Fetcher.R");


#id of all child categories
#input is DATAFRAME
prompter <- function(df){


  categoryIDVector <- df$ID;

#BASE CASE FOR RECURSIVE PROMPTS############################################
  if(length(categoryIDVector) == 0){
    #ACCOUNT FOR OPTIONS OF CATEGORY WITH ZERO CHILDREN#####################
    cat("categoryIDVector length = 0");
    return;
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
#HAVE TO PRESENT THESE OPTIONS IN BASE CASE (categoryIDVector length = 0) make a function
  cat("Would you like to see the series of this category? [y/n]\n");
  userInputConfirm <- readLines("stdin", n=1);
  if(userInputConfirm == "y"){

      #present options for a selected category
      cat("WOULD BE SERIES OPTIONS FOR SELECTED CATEGORY");
      return;

  }else{

    cat("\nWould you like to see the children categories of this category? [y/n]\n");
    userInputConfirm <- readLines("stdin", n=1);
    if(userInputConfirm == "y"){

      #get children of selected category
      responseDF <- fetcherChildren(userInput);
      print(responseDF, row.names=FALSE);
      prompter(responseDF);

    }else{

      cat("\nWould you like to go back to start (root children) [y/n]\n");
      userInputConfirm <- readLines("stdin", n=1);
      if(userInputConfirm == "y"){

        #go back to root children
        responseDF <- fetcherRoot();
        print(responseDF, row.names=FALSE);
        prompter(responseDF);

      }
    }
  }


}
