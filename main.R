#test whether dependencies are included by Fether.R (DON'T NEED, COMES WITH Fether.R)
# library(httr);
# library(jsonlite);
#bringing in Fetcher.R (have access to fetcherRoot and fetcherChildren functions)
source("Fetcher.R");
#STARTUP PROMPT###############################################################
#getting/validating section input from user (1st round)
cat("Please select (type) a section number from the following:\n");
cat("\n1)\tcategory(ALL OPTIONS DEFAULT TO CATEGORY)\n2)\treleases(WIP)\n3)\tseries(WIP)\n4)\tsources(WIP)\n5)\ttags(WIP)\n\n");
userInput <- readLines("stdin", n=1);
while(
  userInput != "1" &
  userInput != "2" &
  userInput != "3" &
  userInput != "4" &
  userInput != "5"){
    cat("Not a valid section, select again\n");
    userInput <- readLines("stdin", n=1);
  }
cat("\n"); #input/output spacing
#CATEGORY INITIAL SHOW########################################################
responseDF <- fetcherRoot();
print(responseDF, row.names=FALSE);





#CATEGORY CHILDREN SHOW#######################################################
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
