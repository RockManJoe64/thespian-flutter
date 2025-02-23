#!/bin/bash

#CREDIT_ID=52fe425bc3a36847f80181c1 # Neo in The Matrix
CREDIT_ID=52fe425cc3a36847f801836f # Neo in the Matrix Reloaded
#CREDIT_ID=52fe425cc3a36847f80184f5 # Neo in The Matrix Revolutions
#CREDIT_ID=5d5c58dbc4904800167c7da0 # Neo in The Matrix Resurrections

curl --request GET \
     --url https://api.themoviedb.org/3/credit/$CREDIT_ID \
     --header "Authorization: Bearer $TMDB_AUTH_TOKEN" \
     --header 'accept: application/json'
