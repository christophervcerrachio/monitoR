#test whether dependencies are included by Fether.R
library(httr);
library(jsonlite);

#bringing in Fetcher.R (have access to fetcherRoot and fetcherChildren functions)
source("Fetcher.R");





#STARTUP PROMPT######################################
#getting/validating section input from user (1st round)
cat("Please select (type) a section from the following:\n");
cat("\n\t category(ALL OPTIONS DEFAULT TO CATEGORY AS OF NOW)\n\t releases(WIP)\n\t series(WIP)\n\t sources(WIP)\n\t tags(WIP)\n\n");
userInput <- readLines("stdin", n=1);
while(
  userInput != "category" &
  userInput != "releases" &
  userInput != "series" &
  userInput != "sources" &
  userInput != "tags"){
    cat("Not a valid section, select again\n");
    userInput <- readLines("stdin", n=1);
  }
cat("\n"); #input/output spacing





#CATEGORY INITIAL SHOW######################################
responseDF <- fetcherRoot();
print(responseDF, row.names=FALSE);





#CATEGORY CHILDREN SHOW######################################
#getting/validating id input from user (round 2)
categoryIDVector <- responseDF$ID;
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

#fetcherChildren body was HERE
responseDF <- fetcherChildren(userInput);
print(responseDF, row.names=FALSE);



#get/visualize series from category chosen by user
