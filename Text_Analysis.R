library(downloader)
library(tm)
library(corrplot)
require(ggplot2)
wcdir <- "C:/Aarohi DataFiles/Studies/MS/03 - Sem 3/CSCI 6444 - Intro to Big Data and Analytics/Group Project 1/text analysis"
wccorp <- VCorpus(DirSource(wcdir))
## The corpus content
summary (wccorp)
wccorp
inspect(wccorp)


## The number of lines in the files and sizes
nbLines <- function(f)
{
  con <- file(f, "r") 
  nblines <- 0L;
  
  while (length(l <- readLines(con,1)) > 0)
    nblines <- nblines + length(l); 
  close(con)
  nblines
}


nbLines ("C:/Aarohi DataFiles/Studies/MS/03 - Sem 3/CSCI 6444 - Intro to Big Data and Analytics/Group Project 1/text analysis/Group_Project_1_Text_for_Analysis.txt")
file.info("C:/Aarohi DataFiles/Studies/MS/03 - Sem 3/CSCI 6444 - Intro to Big Data and Analytics/Group Project 1/text analysis/Group_Project_1_Text_for_Analysis.txt")$size / 32

# Tidying the corpus
# transform to lower characters
twccorp <- tm_map(wccorp, content_transformer(tolower))

# Removing whitespaces
twccorp <- tm_map(twccorp, stripWhitespace)

# Remove punctuation
twccorp <- tm_map(twccorp, removePunctuation, preserve_intra_word_dashes = TRUE)

# Remove numbers
twccorp <- tm_map(twccorp, removeNumbers)

# Remove terms that are words like <1uehft>
(f <- content_transformer(function(x, pattern) gsub(pattern, "", x)))

twccorp <- tm_map(twccorp, f, "<.+>")

# Document Term Matrix
TAdtm <- DocumentTermMatrix(twccorp)
TAdtm

# Term Document Matrix
TAtdm <- TermDocumentMatrix(twccorp)
TAtdm

inspect(TAtdm[1:12,1:2])

# Get list of stop words
myStopWords <- c(stopwords('english'))
myStopWords

# Remove the stop words from corpus
TAstop <- tm_map(twccorp, removeWords, myStopWords)
inspect(TAstop[1])



# create a term document matrix without stop words
TAtdm2 <- TermDocumentMatrix(TAstop[1], control = list(wordlengths = c(1,Inf)))
TAtdm2

# Calculate the frequency of each token in corpus
test1df <- as.data.frame(termFreq(TAstop[[1]]))
test1df

# Find words with frequency greater than or equal to 4
freqTerms <- findFreqTerms(TAtdm2, lowfreq = 4)
freqTerms


# N- gram algorithm
require(RWeka)

ngram <- function(n)
{
  ngramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = n, max = n))
  tdm <- TermDocumentMatrix(TAstop[1], control = list(tokenize = ngramTokenizer))
  inspect(tdm)
  
  # inspect frequency of each biagram and find 4 or more frequent ones
  freq = sort(rowSums(as.matrix(tdm)),decreasing = TRUE)
  freq.df = data.frame(word=names(freq), freq=freq)
  head(freq.df,21)
  
  # Find words with frequency greater than or equal to 4
  #freqTerms <- findFreqTerms(tdm, lowfreq = 4)
  #freqTerms
 
}

ngram(2)



