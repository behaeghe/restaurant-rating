## ----connect to YELP-----------------------------------------------------
myAppId <- "ghOan2cbx0UzUjVsL7ks9A"
appSecret <- "h5kMON9PwG2cc9XuhxqcisAH9F05XEiLd13aJIBY5ARpOYftEgaB7To5GGFhgKuk"
appName <- "YELP"
api.url <- "https://api.yelp.com"
limit =10
##1. Create end point
yelp <- oauth_endpoint(base_url = api.url,
  "request_token",
  "authorize",
  "access_token"
)
## Secret stuff
consumer.key <- "Hv0N4P2YuRvAJkqGpvT4JQ"
consumer.secret <- "eEIXidjmKP4kwB5GViOjgheyJ8g"
yelp.token <- "X6DKWkaBorPWf7spPS1HoziY2XN2FRYK"
yelp.token.secret <- "ttgOz6HfjAjvLcEyoGoTT-__Tak"
require(httr)
require(httpuv)
require(jsonlite)
yelp.app <- oauth_app(appName,key=consumer.key,secret=consumer.secret)
myyelp.token <- oauth1.0_token(yelp,yelp.app,as_header=FALSE)
mySignature <- sign_oauth1.0(yelp.app,
                       token=yelp.token,
                       token_secret=yelp.token.secret
                       )
yelpURL <- paste0("http://api.yelp.com/v2/search/?limit=",limit,"&term=chinese&location=London,UK")
locationData <- GET(yelpURL, mySignature)

require(jsonlite)
locationDataContent = content(locationData)
locationList=jsonlite::fromJSON(toJSON(locationDataContent))
results <- data.frame(locationList)
results$businesses.id

