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

#getting/formatting all child categories of root category (use variables in get request later)
rootChildrenResponse <- GET("https://api.stlouisfed.org/fred/category/children?category_id=0&api_key=03fc1426e63a56cf48dece52f36227ac&file_type=json");
print(rootChildrenResponse);
apiResponseData <- fromJSON(rawToChar(rootChildrenResponse$content));

#extract children category id,name and present to user for further selection
print(typeof(apiResponseData));
print(apiResponseData);

#getting/validating id input from user
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
