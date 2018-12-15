library(spotifyr)
library(tidyverse)
library(plyr)
library(network)

key <- "c6d168d4efa0208423e0d46b6323a1fb"
httr::set_config(httr::config(http_version = 0))
client_id <- "fb15627b4633438596730c2fe62f8dd4"
secret <- "a62ba09e1734499f81162f39dfbb39c1"

Sys.setenv(SPOTIFY_CLIENT_ID = "fb15627b4633438596730c2fe62f8dd4")
Sys.setenv(SPOTIFY_CLIENT_SECRET = secret)

access_token <- get_spotify_access_token()

###get playlist####
user_mariana <- '12129686008'
user_caio <- "caiogoncalves"
Playlists <- get_user_playlists(user_caio)
playlist_tracks <- get_playlist_tracks(Playlists)

playlist_tracks_filtred <- playlist_tracks[playlist_tracks$playlist_name == Playlists$playlist_name[1],]

playlist_lyrics <-data.frame()

for (i in 1:nrow(playlist_tracks_filtred)) {
  artist <- playlist_tracks_filtred$artist_name[i]
  track <- playlist_tracks_filtred$track_name[i]
  lyrics <- possible_lyrics(abjutils::rm_accent(artist), abjutils::rm_accent(track))
  lyrics$artist <- artist
  if(nrow(lyrics) > 0){ playlist_lyrics <- bind_rows(playlist_lyrics,lyrics)}
}

text_token <- tidytext::unnest_tokens(playlist_lyrics, input="lyric", output="word")

text_token <- text_token %>% 
inner_join(tidytext::get_sentiments("afinn"))

stop_words <-  stopwords::stopwords(language = "pt", source = "stopwords-iso")
stop_words_en <-  stopwords::stopwords(language = "en", source = "stopwords-iso")

text_token_cleared <- text_token %>%
  dplyr::count(word, sort = TRUE)

text_token_cleared <- text_token_cleared %>%
  filter(!word %in% stop_words_en)
text_token_cleared <- text_token_cleared %>%
  filter(!word %in% stop_words)


wordcloud2::wordcloud2(text_token_cleared, size=0.7)

 
ggplot(text_token_cleared) + geom_bar(aes(x = sentiment))

ggplot(text_token) + geom_bar(aes(x = artist))
ggplot(text_token) + geom_bar(aes(x = sentiment))
ggplot(text_token) + geom_bar(aes(x = sentiment)) + facet_grid(artist ~ .)


