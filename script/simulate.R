library(tidyverse)
library(ggplot2)
library(dplyr)

set.seed(42)

# assume there are 100 pop music for each country
n_songs <- 100

data <- tibble(
  country = rep(c("US", "CA", "UK", "AUS"), each = n_songs),
  danceability = c(rnorm(n_songs, mean = 0.7, sd = 0.1),  
                   rnorm(n_songs, mean = 0.8, sd = 0.1), 
                   rnorm(n_songs, mean = 0.9, sd = 0.1), 
                   rnorm(n_songs, mean = 0.6, sd = 0.1)),
  energy = c(rnorm(n_songs, mean = 0.6, sd = 0.15),
             rnorm(n_songs, mean = 0.7, sd = 0.15),
             rnorm(n_songs, mean = 0.65, sd = 0.15),
             rnorm(n_songs, mean = 0.62, sd = 0.15)),
  valence = c(rnorm(n_songs, mean = 0.55, sd = 0.2),
              rnorm(n_songs, mean = 0.6, sd = 0.2),
              rnorm(n_songs, mean = 0.57, sd = 0.2),
              rnorm(n_songs, mean = 0.58, sd = 0.2)),
  speechiness = c(rnorm(n_songs, mean = 0.1, sd = 0.05),
                  rnorm(n_songs, mean = 0.06, sd = 0.05),
                  rnorm(n_songs, mean = 0.07, sd = 0.05),
                  rnorm(n_songs, mean = 0.09, sd = 0.05))
)

# show distribution of four features across four countries
ggplot(data, aes(x = country, y = danceability, fill = country)) +
  geom_boxplot() +
  labs(title = "Danceability across Countries", y = "Danceability")

ggplot(data, aes(x = country, y = energy, fill = country)) +
  geom_boxplot() +
  labs(title = "Energy across Countries", y = "Energy")

ggplot(data, aes(x = country, y = valence, fill = country)) +
  geom_boxplot() +
  labs(title = "Valence across Countries", y = "Valence")

ggplot(data, aes(x = country, y = speechiness, fill = country)) +
  geom_boxplot() +
  labs(title = "Speechiness across Countries", y = "Speechiness")

# ANOVA analysis for each feature
anova_danceability <- aov(danceability ~ country, data = data)
anova_energy <- aov(energy ~ country, data = data)
anova_valence <- aov(valence ~ country, data = data)
anova_speechiness <- aov(speechiness ~ country, data = data)

# check ANOVA result
summary(anova_danceability)
summary(anova_energy)
summary(anova_valence)
summary(anova_speechiness)

summary_stats <- data %>%
  group_by(country) %>%
  summarise(
    mean_danceability = mean(danceability),
    sd_danceability = sd(danceability),
    mean_energy = mean(energy),
    sd_energy = sd(energy),
    mean_valence = mean(valence),
    sd_valence = sd(valence),
    mean_speechiness = mean(speechiness),
    sd_speechiness = sd(speechiness)
  )

print(summary_stats)
