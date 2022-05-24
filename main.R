source("Fetcher.R");
source("Prompter.R");

cat("Please select (type) a section number from the following:\n");
cat("\n1)\tcategory(ALL OPTIONS DEFAULT TO CATEGORY)\n2)\treleases(WIP)\n3)\tseries(WIP)\n4)\tsources(WIP)\n5)\ttags(WIP)\n\n");
userInput <- readLines("stdin", n=1);
#########################################################################################
while(
    userInput != "1" &
    userInput != "2" &
    userInput != "3" &
    userInput != "4" &
    userInput != "5"
    ){
        cat("Not a valid section, select again\n");
        userInput <- readLines("stdin", n=1);
    }
#########################################################################################
cat("\n");
responseDF <- fetcherRoot();
print(responseDF, row.names=FALSE);
prompter(responseDF);
