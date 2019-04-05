# Set working directory
setwd("F:/Disk_X/Kinito.Revolution/3-files")

# Load movies by country hierarchy
hierarchy <- read.csv("Hierarchy.csv")

# Peek at hierarchy
head(hierarchy, 5)

# Create a tree path column
hierarchy$Path <- paste(
    "All",
    hierarchy$Continent,
    hierarchy$Country,
    sep = "/")

# Peek at the path
head(hierarchy$Path)

# Load the tree package
library(data.tree)

# Create a tree from a data frame
tree <- as.Node(
    x = hierarchy,
    pathName = "Path")

# Print the tree
print(tree, limit = 10)

# Plot tree
plot(tree)

# Load igraph package
library(igraph)

# Create tree graph
treeGraph <- as.igraph(tree)

# Plot tree graph
plot(
    x = treeGraph,
    main = "Geographic Distribution Hierarchy")

# Add row names for dendro labels
row.names(hierarchy) <- hierarchy$Country

# Peek at the results
head(hierarchy, 5)

# Create distance matrix
distance <- dist(hierarchy[,c(3,4)])

# Peek at distance matrix
round(distance, 0)

# Create hierarchical clusters
clusters <- hclust(distance)

# Create dendrogram
plot(
    x = clusters,
    main = "Hierarchical Clusters of Countries")

# Load APE package
library(ape)

# Create a phylogenic tree
phylo <- as.phylo(clusters)

# Create a radial tree
plot(
    x = phylo,
    type = "fan")

# Load the treemap package
library(treemap)

# Create a frequency treemap
treemap(
    dtf = hierarchy,
    index = c("Continent", "Country"),
    vSize = "Count",
    vColor = "Continent",
    type = "categorical",
    title = "Count of Movies by Continent and Country",
    position.legend = "none")

# Create a treemap
treemap(
    dtf = hierarchy,
    index = c("Continent", "Country"),
    vSize = "Count",
    vColor = "Box.Office",
    type = "value",
    palette = c("#FF681D", "#FFE1D2"),
    title = "Count of Movies and Average Box Office Revenue\nby Continent and Country",
    title.legend = "Average Box Office Revenue ($M)")
