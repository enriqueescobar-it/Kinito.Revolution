#env var
gDriveHome <- gsub("\\\\", "/", Sys.getenv("GDrive"));
#shared folder
gDriveFolder <- "MiApp";
#namespace
gDriveProject <- "Kinito.Revolution";
write(paste0(c("Namespace.....\t", gDriveProject), sep = "", collapse = ""), stdout());
#environment
gDriveSpace <- "RCommon";
#path
write(paste0(c("Environment...\t", gDriveSpace), sep = "", collapse = ""), stdout());
gDriveList <- c(gDriveHome, gDriveFolder, gDriveProject, gDriveSpace);
gDrivePath <- paste0(gDriveList, sep = "/", collapse = "");
write(paste0(c("Path old......\t", getwd()), sep = "", collapse = ""), stderr());
setwd(gDrivePath);
write(paste0(c("Path..........\t", getwd()), sep = "", collapse = ""), stdout());
#doc
gDriveDoc <- paste0(c(gDriveSpace, "Doc"), sep = "/", collapse = "");
write(paste0(c("Doc folder....\t", gDriveDoc), sep = "", collapse = ""), stdout());
#lib
gDriveLib <- paste0(c(gDriveSpace, "Lib"), sep = "/", collapse = "");
write(paste0(c("Lib folder....\t", gDriveLib), sep = "", collapse = ""), stdout());
#util
gDriveUtil <- paste0(c("Lib/", gDriveSpace, ".Util.R"), sep = "", collapse = "");
write(paste0(c("Load Util........\t", gDriveUtil), sep = "", collapse = ""), stdout());
source(gDriveUtil);
#
fileURL <- "https://github.com/jpatokal/openflights/blob/master/data/airports.dat";
filePath <- paste0(c(gDrivePath, "Doc/airports.dat"), sep = "", collapse = "");
#download.file(fileURL, filePath, method="curl");
airports <- read.csv(filePath, header = FALSE, stringsAsFactors = FALSE);
#colnames(airports)<-c("ID", "name", "city", "country", "IATA_FAA", "ICAO", "lat", "lon", "altitude", "timezone");
filePath <- paste0(c(gDrivePath, "Doc/routes.dat"), sep = "", collapse = "");
routes <- read.csv(filePath, header = FALSE, stringsAsFactors = FALSE);
usa_airports <- read.csv("https://raw.githubusercontent.com/jflam/VSBlogPost/master/usa_airports.dat", stringsAsFactors = TRUE);
library(DT);
datatable(usa_airports[, c("name", "city", "country", "IATA_FAA", "lat", "lon", "altitude")]);
library(dplyr);
new_york_airports <- subset(usa_airports, city == "New York");
datatable(new_york_airports[, c("name", "city", "country", "IATA_FAA", "lat", "lon", "altitude")]);
low_nyc <-
  usa_airports %>%
  filter(city == "New York" & altitude < 25) %>%
  arrange(altitude) %>%
  select(name, altitude, lat, lon);
datatable(low_nyc);
library(leaflet);
map <-
  new_york_airports %>%
  leaflet() %>%
  addTiles() %>%
  addCircles( ~ lon, ~ lat, popup = ~name, radius = 200, color = "blue", opacity = 0.8);
map;
