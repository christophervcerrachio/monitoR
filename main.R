library(httr);
library(jsonlite);

#constants: api key, root url, file type
apiKey <- "api_key=03fc1426e63a56cf48dece52f36227ac";
rootURL <- "https://api.stlouisfed.org/fred/";
fileType <- "file_type=json";

#getting/validating section input from user
cat("Please select (type) a section from the following:\n");
cat("\n\t category\n\t releases(WIP)\n\t series(WIP)\n\t sources(WIP)\n\t tags(WIP)\n\n");
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


#getting/validating id input from user
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


#id selected by user from the dataframe
selectedID <- userInput;





















#get/visualize series from category chosen by user


# #default section id = 0 if not specified
# userSection <- userInput;
# userSectionParam <- userSection;
# userSectionParam <- paste(userSectionParam, "_id", sep="");
# userSectionID <- "0";
#
# #building request url string from construct vector
# urlConstruct <- c(rootURL, userSection, "?", userSectionParam, "=", userSectionID,
# "&", apiKey,
# "&", fileType);
# urlString <- paste(urlConstruct, collapse="");
#
# #TESTING REGION###################################################################################
#
# #TESTING URL
#   #"https://api.stlouisfed.org/fred/category?category_id=125&api_key=KEYHERE&file_type=json"
#
# #API response variable
# apiResponse <- GET(urlString);
#
# #converting api response data into list data structure
# apiResponseData <- fromJSON(rawToChar(apiResponse$content));
#
# #SUCCESSFULLY GOT ROOT CATEGORY RESPONSE
# print(apiResponseData);
