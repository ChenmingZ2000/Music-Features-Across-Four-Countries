library(spotifyr)
library(dplyr)
library(ggplot2)
library(knitr)
library(patchwork)

# Define a function to get the popular lists of different countries
get_country_top_tracks <- function(country_playlist_id, country_name) {
  tracks <- get_playlist_tracks(country_playlist_id)
  tracks <- tracks %>%
    mutate(country = country_name, added_at = as.Date(added_at))
  return(tracks)
}

countries <- c("GB", "US", "AU", "CA")

music_data <- data.frame()

for (country in countries) {
  top_tracks <- get_playlist_tracks("37i9dQZEVXbLRQDuF5jeBp", market = country)
  # get track_id and audio_features
  track_ids <- top_tracks$track.id
  audio_features <- get_track_audio_features(track_ids)
  audio_features$country <- country
  music_data <- bind_rows(music_data, audio_features)
}

music_data <- music_data %>%
  select(country, danceability, energy, valence, speechiness)


write_csv(music_data, "data/music_data.csv")
