#!/bin/bash

MOVIE_ID=603 # The Matrix

curl --request GET \
     --url "https://api.themoviedb.org/3/movie/$MOVIE_ID?language=en-US" \
     --header "Authorization: Bearer $TMDB_AUTH_TOKEN" \
     --header 'accept: application/json'

