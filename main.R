library(httr);
library(jsonlite);

#constants: api key, root url, file type
apiKey <- "api_key=03fc1426e63a56cf48dece52f36227ac";
rootURL <- "https://api.stlouisfed.org/fred/";
fileType <- "file_type=json";

#default section VALUE and ID
  #IF USER INPUT doesn't specify (Categories, Releases, Series, Sources, Tags)
  #create user prompt for section specification
userSection <- "category";

userSectionParam <- userSection;
userSectionParam <- paste(userSectionParam, "_id", sep="");
userSectionID <- "0";

#building request url string from construct vector
urlConstruct <- c(rootURL, userSection, "?", userSectionParam, "=", userSectionID,
"&", apiKey,
"&", fileType);
urlString <- paste(urlConstruct, collapse="");

#TESTING REGION###################################################################################

#TESTING URL
  #"https://api.stlouisfed.org/fred/category?category_id=125&api_key=KEYHERE&file_type=json"

#API response variable
apiResponse <- GET(urlString);
print(apiResponse);
