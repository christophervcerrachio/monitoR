library(httr);
library(jsonlite);


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
#getting/formatting all child categories of root category (use variables in get request later)
rootChildrenResponse <- GET("https://api.stlouisfed.org/fred/category/children?category_id=0&api_key=03fc1426e63a56cf48dece52f36227ac&file_type=json");
apiResponseData <- fromJSON(rawToChar(rootChildrenResponse$content));
#extract children category columns id,name for further selection from user
#make dataframe for id,name from list
responseDF <- as.data.frame(apiResponseData);
#isolating id,name columns in new dataframe
responseDF <- responseDF[, c("categories.id", "categories.name")];
#changing column names in new dataframe
colnames(responseDF) <- c("ID", "NAME");
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
#category id selected by user from the dataframe
selectedID <- userInput;
#get children of selected category (need to be REPEATABLE from here, down to situation where category has no children)
selectedChildrenConstruct <- c("https://api.stlouisfed.org/fred/category/children?category_id=", selectedID,"&api_key=03fc1426e63a56cf48dece52f36227ac&file_type=json");
selectedChildrenConstruct <- paste(selectedChildrenConstruct, collapse="");
selectedChildrenConstruct <- GET(selectedChildrenConstruct);
apiResponseData <- fromJSON(rawToChar(selectedChildrenConstruct$content));
responseDF <- as.data.frame(apiResponseData);
responseDF <- responseDF[, c("categories.id", "categories.name")];
colnames(responseDF) <- c("ID", "NAME");
print(responseDF, row.names=FALSE);


#CATEGORY CHILDREN SHOW TWO######################################
#getting/validating id input from user (round 3)
categoryIDVector <- responseDF$ID;
cat("\nPlease select (type) a category id from the table for related categories\n");
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







#get/visualize series from category chosen by user
