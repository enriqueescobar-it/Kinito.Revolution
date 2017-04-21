#Loading the rvest package
library('rvest')
#Specifying the url for desired website to be scrapped
url <- 'http://www.imdb.com/search/title?count=100&release_date=2016,2016&title_type=feature'
#Reading the HTML code from the website
webpage <- xml2::read_html(url)
#Step 3: Once you know the CSS selector that contains the rankings, you can use this simple R code to get all the rankings:
#Using CSS selectors to scrap the rankings section
rank_data_html <- rvest::html_nodes(webpage,'.text-primary')
#Converting the ranking data to text
rank_data <- rvest::html_text(rank_data_html)
#Let's have a look at the rankings
head(rank_data)
#Step 4: Once you have the data, make sure that it looks in the desired format. I am preprocessing my data to convert it to numerical format.
#Data-Preprocessing: Converting rankings to numerical
rank_data<-as.numeric(rank_data)
#Let's have another look at the rankings
head(rank_data)
#Step 6: Again, I have the corresponding CSS selector for the titles – .lister-item-header
#Using CSS selectors to scrap the title section
title_data_html <- rvest::html_nodes(webpage,'.lister-item-header a')
#Converting the title data to text
title_data <- rvest::html_text(title_data_html)
#Let's have a look at the title
head(title_data)
#Step 7: In the following code, I have done the same thing for scrapping – Description
#Using CSS selectors to scrap the description section
description_data_html <- rvest::html_nodes(webpage,'.ratings-bar+ .text-muted')
#Converting the description data to text
description_data <- rvest::html_text(description_data_html)
#Let's have a look at the description data
head(description_data)
#Data-Preprocessing: removing '\n'
description_data<-gsub("\n","",description_data)
#Let's have another look at the description data 
head(description_data)
#Using CSS selectors to scrap the Movie runtime section
runtime_data_html <- rvest::html_nodes(webpage,'.text-muted .runtime')
#Converting the runtime data to text
runtime_data <- rvest::html_text(runtime_data_html)
#Let's have a look at the runtime
head(runtime_data)
#Data-Preprocessing: removing mins and converting it to numerical
runtime_data<-gsub(" min","",runtime_data)
runtime_data<-as.numeric(runtime_data)
#Let's have another look at the runtime data
head(rank_data)
#Using CSS selectors to scrap the Movie genre section
genre_data_html <- rvest::html_nodes(webpage,'.genre')
#Converting the genre data to text
genre_data <- rvest::html_text(genre_data_html)
#Let's have a look at the runtime
head(genre_data)
#Data-Preprocessing: removing \n
genre_data<-gsub("\n","",genre_data)
#Data-Preprocessing: removing excess spaces
genre_data<-gsub(" ","",genre_data)
#taking only the first genre of each movie
genre_data<-gsub(",.*","",genre_data)
#Convering each genre from text to factor
genre_data<-as.factor(genre_data)
#Let's have another look at the genre data
head(genre_data)
#Using CSS selectors to scrap the IMDB rating section
rating_data_html <- rvest::html_nodes(webpage,'.ratings-imdb-rating strong')
#Converting the ratings data to text
rating_data <- rvest::html_text(rating_data_html)
#Let's have a look at the ratings
head(rating_data)
#Data-Preprocessing: converting ratings to numerical
rating_data<-as.numeric(rating_data)
#Let's have another look at the ratings data
head(rating_data)
#Using CSS selectors to scrap the votes section
votes_data_html <- rvest::html_nodes(webpage,'.sort-num_votes-visible span:nth-child(2)')
#Converting the votes data to text
votes_data <- html_text(votes_data_html)
#Let's have a look at the votes data
head(votes_data)
#Data-Preprocessing: removing commas
votes_data<-gsub(",","",votes_data)
#Data-Preprocessing: converting votes to numerical
votes_data<-as.numeric(votes_data)
#Let's have another look at the votes data
head(votes_data)
#Using CSS selectors to scrap the directors section
directors_data_html <- rvest::html_nodes(webpage,'.text-muted+ p a:nth-child(1)')
#Converting the directors data to text
directors_data <- rvest::html_text(directors_data_html)
#Let's have a look at the directors data
head(directors_data)
#Data-Preprocessing: converting directors data into factors
directors_data<-as.factor(directors_data)
#Using CSS selectors to scrap the actors section
actors_data_html <- rvest::html_nodes(webpage,'.lister-item-content .ghost+ a')
#Converting the gross actors data to text
actors_data <- rvest::html_text(actors_data_html)
#Let's have a look at the actors data
head(actors_data)
#Data-Preprocessing: converting actors data into factors
actors_data<-as.factor(actors_data)
#Using CSS selectors to scrap the metascore section
metascore_data_html <- rvest::html_nodes(webpage,'.metascore')
#Converting the runtime data to text
metascore_data <- rvest::html_text(metascore_data_html)
#Let's have a look at the metascore data
head(metascore_data)
#Data-Preprocessing: removing extra space in metascore
metascore_data<-gsub(" ","",metascore_data)
#Lets check the length of metascore data
length(metascore_data)
#
for (i in c(39,73,80,89)){
  a<-metascore_data[1:(i-1)]
  b<-metascore_data[i:length(metascore_data)]
  metascore_data<-append(a,list("NA"))
  metascore_data<-append(metascore_data,b)
}
#Data-Preprocessing: converting metascore to numerical
metascore_data<-as.numeric(metascore_data)
#Let's have another look at length of the metascore data
length(metascore_data)
#Let's look at summary statistics
summary(metascore_data)
#Using CSS selectors to scrap the gross revenue section
gross_data_html <- rvest::html_nodes(webpage,'.ghost~ .text-muted+ span')
#Converting the gross revenue data to text
gross_data <- rvest::html_text(gross_data_html)
#Let's have a look at the votes data
head(gross_data)
#Data-Preprocessing: removing '$' and 'M' signs
gross_data<-gsub("M","",gross_data)
gross_data<-substring(gross_data,2,6)
#Let's check the length of gross data
length(gross_data)
#Filling missing entries with NA
for (i in c(17,39,49,52,57,64,66,73,76,77,80,87,88,89)){
  a<-gross_data[1:(i-1)]
  b<-gross_data[i:length(gross_data)]
  gross_data<-append(a,list("NA"))
  gross_data<-append(gross_data,b)
}
#Data-Preprocessing: converting gross to numerical
gross_data<-as.numeric(gross_data)
#Let's have another look at the length of gross data
length(gross_data)
summary(gross_data)
#Combining all the lists to form a data frame
movies_df<-data.frame(Rank = rank_data,
                      Title = title_data,
                      Description = description_data,
                      Runtime = runtime_data,
                      Genre = genre_data,
                      Rating = rating_data,
                      Metascore = metascore_data,
                      Votes = votes_data,
                      Gross_Earning_in_Mil = gross_data,
                      Director = directors_data,
                      Actor = actors_data)
#Structure of the data frame
str(movies_df)
library('ggplot2')
qplot(data = movies_df,Runtime,fill = Genre,bins = 30)
ggplot(movies_df,aes(x=Runtime,y=Rating)) +
geom_point(aes(size=Votes,col=Genre))
ggplot(movies_df,aes(x=Runtime,y=Gross_Earning_in_Mil)) +
geom_point(aes(size=Rating,col=Genre))






