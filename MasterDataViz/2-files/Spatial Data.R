# Load ggplot2
library(ggplot2)
require("maps");
# Create a base map (no data)
ggplot() +
    borders(
        database = "world",
        colour = "grey60",
        fill = "grey90") +
    ggtitle("Base Map of the World") +
    xlab("") +
    ylab("") +
    theme(
        panel.background = element_blank(),
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())

# Set working directory setwd("C:/Pluralsight")
setwd("F:/Disk_X/Kinito.Revolution/2-files");

# Read movies by country from CSV file
movies <- read.csv("Movies by Country.csv")

# Peek at movies by country
head(movies)

# Create a dot density map
ggplot(
    data = movies) +
    borders(
        database = "world",
        colour = "grey60",
        fill = "grey90") +
    geom_point(
        aes(
            x = Longitude,
            y = Latitude)) +
    ggtitle("Movies by Country") +
    xlab("") +
    ylab("") +
    theme(
        panel.background = element_blank(),
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())

# Create a contour map
ggplot(
    data = movies) +
    borders(
        database = "world",
        colour = "grey60",
        fill = "grey90") +
    geom_density2d(
        aes(
            x = Longitude,
            y = Latitude)) +
    ggtitle("Density of Movies by Country") +
    xlab("") +
    ylab("") +
    theme(
        panel.background = element_blank(),
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())

# Zoom into a map
ggplot(
    data = movies) +
    borders(
        database = "world",
        colour = "grey60",
        fill = "grey90") +
    coord_cartesian(
        xlim = c(-20, 59),
        ylim = c(35, 71)) +
    geom_density2d(
        aes(
            x = Longitude,
            y = Latitude)) +
    ggtitle("Density of Movies by Country") +
    xlab("") +
    ylab("") +
    theme(
        panel.background = element_blank(),
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())

# Create a level map
ggplot(
    data = movies) +
    borders(
        database = "world",
        colour = "grey60",
        fill = "grey90") +
    coord_cartesian(
        xlim = c(-20, 59),
        ylim = c(35, 71)) +
    stat_density2d(
        aes(
            x = Longitude,
            y = Latitude,
            alpha = ..level..),
        geom = "polygon",
        fill = "blue") +
    ggtitle("Density of Movies by Country") +
    xlab("") +
    ylab("") +
    labs(alpha = "Density") +
    theme(
        panel.background = element_blank(),
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())

# Read countries from CSV file
countries <- read.csv("Countries.csv")

# Peek at countries
head(countries)

# Create a bubble map
ggplot(
    data = countries) +
    borders(
        database = "world",
        colour = "grey60",
        fill = "grey90") +
    geom_point(
        aes(
            x = Longitude,
            y = Latitude,
            size = Count)) +
    scale_size_area(
        max_size = 5) +
    ggtitle("Count of Movies by Country") +
    xlab("") +
    ylab("") +
    labs(size = "Movies") +
    theme(
        panel.background = element_blank(),
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())

# Load map data as dataframe
map <- map_data("world")

# Peek at the map data
head(map)

# Load dplyr
library(dplyr)

# Join countries and map data
countries2 <- countries %>%
    left_join(map,
        by = c("Country" = "region")) %>%
    select(
        Country,
        Longitude = long,
        Latitude = lat,
        Group = group,
        Order = order,
        Count) %>%
    arrange(Order) %>%
    as.data.frame()

# Peek at results
head(countries2)

# Create a choropleth
ggplot(
    data = countries2) +
    borders(
        database = "world",
        colour = "grey60",
        fill = "grey90") +
    geom_polygon(
        aes(
            x = Longitude,
            y = Latitude,
            group = Group,
            fill = Count),
        color = "grey60") +
    scale_fill_gradient(
        low = "white",
        high = "red") +
    ggtitle("Count of Movies by Country") +
    xlab("") +
    ylab("") +
    labs(color = "Movies") +
    theme(
        panel.background = element_blank(),
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())

# Reproject a map
ggplot(
    data = countries2) +
    borders(
        database = "world",
        colour = "grey60",
        fill = "grey90") +
    coord_map(
        projection = "ortho",
        orientation = c(41, -74, 0)) +
    geom_polygon(
        aes(
            x = Longitude,
            y = Latitude,
            group = Group,
            fill = Count),
        color = "grey60") +
    scale_fill_gradient(
        low = "white",
        high = "red") +
    ggtitle("Count of Movies by Country") +
    xlab("") +
    ylab("") +
    labs(color = "Movies") +
    theme(
        panel.background = element_blank(),
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())

# Map projection help files
?mapproject
