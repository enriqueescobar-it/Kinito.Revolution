# Set working directory
setwd("F:/Disk_X/Kinito.Revolution/5-files")

# Load plot summaries
plots <- read.csv("Plots.csv")

# Convert to characters
plots$Plot <- as.character(plots$Plot)

# Peek at plot keywords
head(plots$Plot, 3)

# Load text mining package
library(tm)

# Load SnowballC package
library(SnowballC)

# Convert plots into a corpus
corpus <- Corpus(VectorSource(plots$Plot))

# Inspect first entry in the corpus
corpus[[1]]$content

# Convert terms to lower case
corpus <- tm_map(corpus, content_transformer(tolower))

# Remove punctuation
corpus <- tm_map(corpus, removePunctuation)

# Remove stop words from corpus
corpus <- tm_map(corpus, removeWords, stopwords("english"))

# Reduce terms to stems in corpus
corpus <- tm_map(corpus, stemDocument, "english")

# Strip whitespace from corpus
corpus <- tm_map(corpus, stripWhitespace)

# Convert corpus to text document
corpus <- tm_map(corpus, PlainTextDocument)

# Inspect first entry in the corpus
corpus[[1]]$content

# Load the wordcloud package
library(wordcloud)

# Create a frequency word cloud
wordcloud(
    words = corpus,
    max.words = 50)

# Load the words data from a CSV file
words <- read.csv("Words.csv")

# Peek at plot keywords
head(words, 10)

# Create a quantitative word cloud
wordcloud(
    words = words$Term,
    freq = words$Box.Office,
    max.words = 50,
    scale = c(2, 0.1))

# Load the color brewer package
library(RColorBrewer)

# Create a gradient color palette
palette <- brewer.pal(
    n = 9,
    name = "Oranges")

# Map critic score to colors
colors <- palette[cut(words$Critic.Score, 9)]

# Create a word cloud with color
wordcloud(
    words = words$Term,
    freq = words$Box.Office,
    max.words = 50,
    scale = c(2, 0.5),
    colors = colors,
    ordered.colors = TRUE)
