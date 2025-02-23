#!/bin/bash

curl --request GET \
     --url 'https://api.themoviedb.org/3/trending/person/day?language=en-US' \
     --header "Authorization: Bearer $TMDB_AUTH_TOKEN" \
     --header 'accept: application/json' \
     --silent --show-error
