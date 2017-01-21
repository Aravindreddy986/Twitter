library(devtools)
install_github("twitteR", username="geoffjentry")

library(twitteR)
library(httr)
library(base64enc)
library(tm)
library(wordcloud)
library(RColorBrewer)
library(stringr)

api_key <- "bdDSzyd67drZXI0hHNvnZBERS"

api_secret <- "FiC4FXJj7HunlAsTQ72S6JLWDyJMsWpO4nXaFY41M4Ta88iAWe"

access_token <- "711869663467016192-QZGHRnqzQUzZAIm2nBEYECXm9n2HMP9"

access_token_secret <- "KXLbcGgQD6GkJWBGu8s8q0eA8NMXoTAIu6AeQvpri6j6D"

setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

searchTwitter("iphone")




hashtg <- "#Trump"
stp <- "trump"
HT <- searchTwitter(hashtg, n = 1000)
HT_text <- sapply(HT, function(x) x$getText())

HT_text <- str_replace_all(HT_text, "[^[a-zA-Z0-9]]", " ")
HT_text <- str_replace_all(HT_text,"http","")

HT_text <- removeWords(HT_text,"the")
HT_text <- removeWords(HT_text,"trump")
HT_text <- removeWords(HT_text,"Trump")

HT_corpus = Corpus(VectorSource(HT_text))

tdm = TermDocumentMatrix(
  HT_corpus,
  control = list(
    removePunctuation = TRUE,
    stopwords = c,
    removeNumbers = TRUE)
)
m = as.matrix(tdm)
# get word counts in decreasing order
word_freqs = sort(rowSums(m), decreasing = TRUE) 
# create a data frame with words and their frequencies
dm = data.frame(word = names(word_freqs), freq = word_freqs)

wordcloud(dm$word, dm$freq, min.freq=25, random.order = FALSE, colors = brewer.pal(4, "Dark2"))

