#!/bin/bash

PERSON_ID=6384 # Keanu Reeves

curl --request GET \
     --url "https://api.themoviedb.org/3/person/$PERSON_ID?language=en-US" \
     --header "Authorization: Bearer $TMDB_AUTH_TOKEN" \
     --header 'accept: application/json' \
     --silent --show-error

