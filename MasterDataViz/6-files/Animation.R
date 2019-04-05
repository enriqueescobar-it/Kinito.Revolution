# Set working directory
setwd("F:/Disk_X/Kinito.Revolution/6-files")

# Load releases by studio by month
studios <- read.csv("Studios.csv")

# Peek at the data
head(studios, 5)

# Load the color brewer package
library(RColorBrewer)

# Create discrete color palette
palette <- brewer.pal(10, "Set3")

# Get the last period data
period <- studios[studios$Period == 183,]

# Create scatterplot of last period (July 2015)
plot(
	x = period$Count,
	y = period$Box.Office,
	xlim = c(0, 225),
	ylim = c(0, 17500),
	col = palette[as.integer(period$Studio)],
	pch = 19,
	cex = 2,
	main = "Top 10 Studios (2000-2015)",
	sub = period$Release,
	xlab = "Movies Released",
	ylab = "Box Office Revenue ($M)")

# Create animation function
animate <- function() {
    for(i in 1:183)
    {
        # Get current period data
        period <- studios[studios$Period == i,]

        # Create scatterplot of current period
        plot(
            x = period$Count,
            y = period$Box.Office,
            xlim = c(0, 225),
            ylim = c(0, 17500),
            col = palette[as.integer(period$Studio)],
            pch = 19,
            cex = 2,
            main = "Top 10 Studios (2000-2015)",
            sub = period$Release,
            xlab = "Movies Released",
            ylab = "Box Office Revenue ($M)")

        # Display legend
        legend(
            x = "bottomright",
            as.character(levels(period$Studio)),
            col = palette[as.integer(period$Studio)],
            pch = 19,
            cex = 0.75)
    }
}

# Load animation package
library(animation)

# Set the frame rate
ani.options(
    interval = 0.067,
    ani.width = 640,
    ani.height = 480)

# Save the animation as a video
saveVideo(
    expr = animate(),
    video.name = "Studios.mp4",
    ffmpeg = "C:\\ProgramData\\chocolatey\\lib\\ffmpeg\\tools\\ffmpeg\\bin\\ffmpeg.exe",
    other.opts = "-r 15 -pix_fmt yuv420p")

# Load CSV data
movies <- read.csv("Movies.csv")

# Create 2014 movies data set
movies2014 <- movies[movies$Year == 2014, ]

# Load lattice package
library(lattice)

# Create animation function
animate2 <- function() {
    for(i in 1:360)
    {
        # Create 3D scatterplot using current angle
        plot <- cloud(
            x = Box.Office ~ Critic.Score * Runtime,
            data = movies2014,
            type = c("p", "h"),
            pch = 16,
            main = "Runtime, Critic Score, and Box Office Revenue",
            xlab = "Runtime\n(min)",
            ylab = "Critic\nScore\n(%)",
            zlab = "Box Office\nRevenue\n($M)",
            R.mat = diag(4),
            screen = list(
                z = i,
                y = 0,
                x = -60))

        # Draw plot
        print(plot)
    }
}

# Save animation as video
saveVideo(
    expr = animate2(),
    video.name = "Cloud.mp4",
    ffmpeg = "C:\\ProgramData\\chocolatey\\lib\\ffmpeg\\tools\\ffmpeg\\bin\\ffmpeg.exe",
    other.opts = "-r 15 -pix_fmt yuv420p")

# Load countries 2 data set
countries2 <- read.csv("Countries2.csv")

# Load the ggplot2 package
library(ggplot2)

# Create an animation function
animate3 <- function() {
    for(i in -180:180)
    {
        # Project a map centered at current longitude
        plot <- ggplot(
            data = countries2) +
            borders(
                database = "world",
                colour = "grey60",
                fill = "grey90") +
            coord_map(
                projection = "ortho",
                orientation = c(0, i, 0)) +
            geom_polygon(
                aes(
                    x = Longitude,
                    y = Latitude,
                    group = Group,
                    fill = Count),
                color = "grey60") +
            scale_fill_gradient(
                low = "white",
                high = "red",
                guide = FALSE) +
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

        print(plot)
    }
}

# Create video of animation
# NOTE: This may take hours
saveVideo(
    expr = animate3(),
    video.name = "Globe.mp4",
    ffmpeg = "C:\\ProgramData\\chocolatey\\lib\\ffmpeg\\tools\\ffmpeg\\bin\\ffmpeg.exe")
