library(httr);
library(jsonlite);

fetcherRoot <- function(){
    rootChildrenResponse <- GET("https://api.stlouisfed.org/fred/category/children?category_id=0&api_key=03fc1426e63a56cf48dece52f36227ac&file_type=json");
    apiResponseData <- fromJSON(rawToChar(rootChildrenResponse$content));
    responseDF <- as.data.frame(apiResponseData);
    responseDF <- responseDF[, c("categories.id", "categories.name")];
    colnames(responseDF) <- c("ID", "NAME");
    responseDF;
}
#########################################################################################
fetcherChildren <- function(id){
    selectedID <- id;
    selectedChildrenConstruct <- c("https://api.stlouisfed.org/fred/category/children?category_id=", selectedID,"&api_key=03fc1426e63a56cf48dece52f36227ac&file_type=json");
    selectedChildrenConstruct <- paste(selectedChildrenConstruct, collapse="");
    selectedChildrenConstruct <- GET(selectedChildrenConstruct);
    apiResponseData <- fromJSON(rawToChar(selectedChildrenConstruct$content));
    responseDF <- as.data.frame(apiResponseData);
    responseDF <- responseDF[, c("categories.id", "categories.name")];
    colnames(responseDF) <- c("ID", "NAME");
    responseDF;
}
#########################################################################################
fetcherCategorySeries <- function(id){
    selectedID <- id;
    selectedSeriesConstruct <- c("https://api.stlouisfed.org/fred/category/series?category_id=", selectedID,"&api_key=03fc1426e63a56cf48dece52f36227ac&file_type=json");
    selectedSeriesConstruct <- paste(selectedSeriesConstruct, collapse="");
    selectedSeriesConstruct <- GET(selectedSeriesConstruct);
    apiResponseData <- fromJSON(rawToChar(selectedSeriesConstruct$content));
    if(length(apiResponseData$seriess) != 0){
        responseDF <- as.data.frame(apiResponseData$seriess);
        responseDF <- responseDF[, c("id", "title")];
        colnames(responseDF) <- c("ID", "TITLE");
        responseDF;
    }else{
        return(-1);
    }
}
#########################################################################################
fetcherSeriesSeries <- function(id){
    selectedID <- id;
    selectedSeriesDataConstruct <- c("https://api.stlouisfed.org/fred/series/observations?series_id=", selectedID,"&api_key=03fc1426e63a56cf48dece52f36227ac&file_type=json");
    selectedSeriesDataConstruct <- paste(selectedSeriesDataConstruct, collapse="");
    selectedSeriesDataConstruct <- GET(selectedSeriesDataConstruct);
    apiResponseData <- fromJSON(rawToChar(selectedSeriesDataConstruct$content));
    if(length(apiResponseData$observations) != 0){
        responseDF <- as.data.frame(apiResponseData$observations);
        responseDF <- responseDF[, c("date", "value")];
        colnames(responseDF) <- c("DATE", "VALUE");
        responseDF;
    }else{
        return(-1);
    }
}
