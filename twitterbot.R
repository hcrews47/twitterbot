library(httr)
library(twitteR)
library(stringr)
library(jsonlite)
library(RCurl)
# library(tm)?

consumer_key = "29f1zVSk9q5KUNPneRP7VEM1l"
consumer_secret = "Yp6mWFIUKhC6wJgtroCnEYY0ZGGsS5pgxDD7Cg6QeiRVcJ5lAg"
access_token = "874190507341205504-6xq8Q4Dpsy1Euy59p1Hub9qS8nnQLAO"
access_secret = "DOTAXHg4rEJt5PdnuPk1PNHnLV1iGMeNY0xdmdsWDVFWC"
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

netbot = getUser('netflix_bot')
net_tweets = userTimeline(netbot, n=50)
net_tweets_df= do.call(rbind, lapply(net_tweets, function(x) x$toDataFrame()))
net_tweets_text  = sapply(net_tweets, function(x) x$getText())

brate<- net_tweets_df %>% select(created)
tweet_date<- mutate(brate, date = as.Date(created))
tweet_date<- tweet_date %>% select(date)
todayz<- Sys.Date()


todays_tweets = which(tweet_date$date == todayz)

final = net_tweets_df[todays_tweets,]
raw_tweet = final$text

g<- sub('\\(.*', '', raw_tweet)
list<- trimws(g, which = c("both", "left", "right"))


omdb_key = 'adb1cfb2'

raw_title = list
title = str_replace_all(raw_title, "[:space:]", "+")
URL = sprintf("http://www.omdbapi.com/?apikey=%s&t=%s", omdb_key, title)
getURL('http://www.omdbapi.com/?apikey=adb1cfb2&t=28+Moons')
for(i in URL){
  raw_text = getURL(i)
  parsed = fromJSON(raw_text)
  if(parsed$Response == "False"){
  } else {
    rt = parsed$Ratings
    if(length(rt) == 0){
      rot = 'NA'
      meta = 'NA'
      imdb = 'NA'
    }else if(rt[1,1] == "Rotten Tomatoes"){
      rot = rt[1,2]
      meta = rt[2,2]
      imdb = rt[3,2]
    } else if(rt[1,1] == "Metacritic"){
      meta = rt[1,2]
      rot = rt[2,2]
      imdb = rt[3,2]
    } else {
      imdb = rt[1,2]
      rot = rt[2,2]
      meta = rt[3,2]
    }
    
    tweet(sprintf("New Netflix Release: %s. Rotten Tomatoes: %s, IMDB Rating: %s, Metacritic: %s", parsed, rot, imdb, meta))
  }
}
