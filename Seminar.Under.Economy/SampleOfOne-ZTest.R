z.test <- function(a, mu, var){
  zeta <- (mean(a) - mu) / (sqrt(var / length(a)));
  
  return(zeta);
}

a = c(65, 78, 88, 55, 48, 95, 66, 57, 79, 81);

z.test(a, 75, 18);

NBAplayerList <- read.delim("Doc/NBAplayers.txt");
head(NBAplayerList);

#unbiased random sample
set.seed(123);
n <- 50;
height_sample <- sample(NBAplayerList$Height, size=n);
sample_mean <- mean(height_sample);

#tall-biased sample
cut <- 1:25000
weights <- cut^.6
sorted_height <- sort(NBAplayerList$Height)
set.seed(123)
height_sample_biased <- sample(sorted_height, size=n, prob=NBAplayerList$Weight)
sample_mean_biased <- mean(height_sample_biased)