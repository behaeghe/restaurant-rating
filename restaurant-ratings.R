##Let's get our libraries first
## Our classic stuff
library(tidyverse)
## Needed for the rest API calls to YELP
require(httr)
require(httpuv)
require(jsonlite)
## Helper Functions
#' CreateSignature
#' Generate Oauth1.0 signature from API keys and tokens
#' @param yAppName 
#' @param yKey 
#' @param ySecret 
#' @param yToken 
#' @param yTokenSecret 
#'
#' @return Auth token 1.0 request
#' @export
#'
#' @examples
createSignature <- function(yAppName,yKey,ySecret,yToken,yTokenSecret) {
    ## function returns an oauth1.0 signature based on
    ## @param yAppnName application name to be used as handled
    ## @param yKey API Key
    ## @param ySecret secret strings
    ## @param yToken Token
    ## @param yTokenSecret Token Secret
    
    yelp.app <- oauth_app(appName,
                          key=yKey,
                          secret=ySecret)
    mySig<- sign_oauth1.0( yelp.app,
                           token=yToken,
                           token_secret=yTokenSecret)
    return(mySig)
}
YelpSearch <- function(term,limit=3,location="Boston,MA",version=3) {
    
    if (version==3) {
        base_url = "https://api.yelp.com/v3/businesses/search"
    } else if(version==2) {
        base_url = "https://api.yelp.com/v2/search"
    } else {
        return(NULL)       
    }
    
    URL <- paste0(base_url,"?",
                  "limit=",
                  limit,
                  "&term=",
                  term,
                  "&location=",
                  location)
    return(URL)
}
YelpReviews <- function(business.id) {
    URL <- paste0("https://api.yelp.com/v3/businesses/",
                  business.id,
                  "/reviews")
    return(URL)
}

## ----connect to YELP-----------------------------------------------------
client.id <- "ghOan2cbx0UzUjVsL7ks9A"
client.secret <- "h5kMON9PwG2cc9XuhxqcisAH9F05XEiLd13aJIBY5ARpOYftEgaB7To5GGFhgKuk"
##appName <- "YELP"
##api.url <- "https://api.yelp.com"

## Constants and Parameters
limit =10
## The Oauth2.0 dance...
## First create endpoints for Yelp
yelp <- oauth_endpoint(
        base_url = "https://api.yelp.com/oauth2",
        access="token",
        authorize="token"
        )
## Register our app 
yelpapp <- oauth_app("Restos",client.id,client.secret)
## finaly get and cache our token
myToken <- oauth2.0_token(yelp,yelpapp,use_oob=TRUE,cache=TRUE)
## Let's try
res <- GET(YelpSearchV3("Chinese"),config(token=myToken))
results <- fromJSON(toJSON(content(res)))
## Connection info for yelp --- OAuth v1.0
consumer.key <- "Hv0N4P2YuRvAJkqGpvT4JQ"
consumer.secret <- "eEIXidjmKP4kwB5GViOjgheyJ8g"
yelp.token <- "X6DKWkaBorPWf7spPS1HoziY2XN2FRYK"
yelp.token.secret <- "ttgOz6HfjAjvLcEyoGoTT-__Tak"


createYelpSignature <- function(yAppName,yKey,ySecret,yToken,yTokenSecret) {
## OAuth1.0 for APIs V2
    yelp.app <- oauth_app(appName,
                          key=yKey,
                          secret=ySecret)
    mySig<- sign_oauth1.0( yelp.app,
                           token=yToken,
                           token_secret=yTokenSecret)
    return(mySig)
}
YelpSearch <- function(term,limit=3,location="Boston,MA",version=3) {
 
   if (version==3) {
       base_url = "https://api.yelp.com/v3/businesses/search"
   } else if(version==2) {
       base_url = "https://api.yelp.com/v2/search"
   } else {
        return(NULL)       
   }
    
    URL <- paste0(base_url,"?",
                                 "limit=",
                                  limit,
                                  "&term=",
                                   term,
                                   "&location=",
                                    location)
    return(URL)
}
YelpReviews <- function(business.id) {
    URL <- paste0("https://api.yelp.com/v3/businesses/",
                  business.id,
                   "/reviews")
    return(URL)
}
# yelp.app <- oauth_app(appName,key=consumer.key,secret=consumer.secret)
# myyelp.token <- oauth1.0_token(yelp,yelp.app,as_header=FALSE)
# mySignature <- sign_oauth1.0(yelp.app,
#                        token=yelp.token,
#                        token_secret=yelp.token.secret
#                        )
#yelpURL <- paste0("http://api.yelp.com/v2/search/?limit=",limit,"&term=chinese&location=London,UK")
# locationData <- GET(yelpURL, mySignature)
# 
# require(jsonlite)
# locationDataContent = content(locationData)
# locationList=jsonlite::fromJSON(toJSON(locationDataContent))
# results <- data.frame(locationList)
# results$businesses.id

