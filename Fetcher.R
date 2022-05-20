library(httr);
library(jsonlite);

#to be run once at selection of category section
fetcherRoot <- function(){
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
  responseDF;
}

#x = category id selected from user
#NEED LOGIC/HELPER FUNCTION hasChildren
fetcherChildren <- function(x){
  #category id selected by user from the dataframe
  selectedID <- x;
  #get children of selected category (need to be REPEATABLE from here, down to situation where category has no children)
  selectedChildrenConstruct <- c("https://api.stlouisfed.org/fred/category/children?category_id=", selectedID,"&api_key=03fc1426e63a56cf48dece52f36227ac&file_type=json");
  selectedChildrenConstruct <- paste(selectedChildrenConstruct, collapse="");
  selectedChildrenConstruct <- GET(selectedChildrenConstruct);
  apiResponseData <- fromJSON(rawToChar(selectedChildrenConstruct$content));
  responseDF <- as.data.frame(apiResponseData);

  #IF CATEGORY HAS NO CHILDREN, json response "categories" field is EMPTY ARRAY
  #check size of categories field in responseDF#########################################
  #HERE#################################################################################






  responseDF <- responseDF[, c("categories.id", "categories.name")];
  colnames(responseDF) <- c("ID", "NAME");
  responseDF;
}
