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