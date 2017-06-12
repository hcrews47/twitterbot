library(httr)
library(twitteR)
library(tm)

consumer_key = "29f1zVSk9q5KUNPneRP7VEM1l"
consumer_secret = "Yp6mWFIUKhC6wJgtroCnEYY0ZGGsS5pgxDD7Cg6QeiRVcJ5lAg"
access_token = "874190507341205504-HprGkep0tLy7ev7ItOn4wbjIcEpQKgk"
access_secret = "HkFD4w8yS6SFgNzeSEw8pDZNa04dhMVfqqzMyGOpzl4wW"
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

tweets = searchTwitter("trump", n = 100, lang = "en")  # 100 tweets about trump
tweet('howdy')
netbot = getUser('netflix_bot')
net_tweets = userTimeline(netbot)
