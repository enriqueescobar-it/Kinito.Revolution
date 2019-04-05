# Set working directory
setwd("F:/Disk_X/Kinito.Revolution/4-files")

# Load actors CSV file
actors <- read.csv("Actors.csv")

# Peek at actors
head(actors)

# Get five-time plus acting pairs
actors5 <- actors[actors$Count >= 5,]

# Load igraph package
library(igraph)

# Create graph of acting pairs
graph5 <- graph.data.frame(
    d = actors5,
    directed = FALSE)

# Plot a small graph
plot(
    x = graph5,
    edge.curved = FALSE,
    main = "Five-time or More Acting Pairs")

# Get actors who have acted together twice or more
actors2 <- actors[actors$Count >= 2,]

# Create a undirected graph object
graph2 <- graph.data.frame(
    d = actors2,
    directed = FALSE)

# Plot a large graph
plot(
    x = graph2,
    vertex.size = 2,
    vertex.label = NA,
    edge.curved = FALSE,
    edge.width = edge_attr(graph2)$Count,
    main = "Twice or More Acting Pairs")

# Create graph clusters
clusters <- cluster_edge_betweenness(graph2)

# Plot communities graph
plot(
    x = clusters,
    y = graph2,
    vertex.size = 3,
    vertex.label = NA,
    edge.curved = FALSE,
    main = "Acting Communities")
