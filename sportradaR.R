#####################################################################################################################################
#----------------                                                                                                                   #
# sportradaR                                                                                                                               #
#----------------                                                                                                                   #
#                                                                                                                                   #
# Set of R functions to interface with the Sport Radar API                                                                     #
#                                                                                                                                   #
#                                                                                                                                   #
# Created by: Nick Holt, PhD, Institute for Advanced Analytics, Bellarmine University                                               #
# Created on: 02-07-18                                                                                                              #
#                                                                                                                                   #
#                                                                                                                                   #
# Current Status: In development                                                                                                    #
#                                                                                                                                   #
# Last edited: 02-07-18                                                                                                             #
#                                                                                                                                   #
# Log:                                                                                                                              #
#       # 02-07-18 : Initialized with basic functionality for Golf API                                                              #
#                                                                                                                                   #
#####################################################################################################################################

# dependencies
library(RCurl)
library(rjson)
library(jsonlite)
library(stringr)
library(lubridate)
library(purrr)
library(dplyr)
library(tidyverse)

# Set of API keys stored in CSV based on data in the table on the following page:
# URL: https://developer.sportradar.com/apps/myapps

# basic functionality for retrieving golf tournament schedules by year and tour
getGolfTournamentSchedule <- function(tour = "pga", year = "2018"){
        start_url <- paste0("http://api.sportradar.us/golf-", access_level, "2", "/schedule/", tour,"/", year, "/tournaments/schedule.json?api_key=", golf_key)
        targetJSON <- getURL(start_url)
        target <- fromJSON(targetJSON)
        tourn_df <- data.frame(target$tournaments)
        course_df <- data.frame(do.call(cbind, tourn_df$venue)) %>% select(-courses)
        colnames(course_df) <- str_c("venue_", colnames(course_df))
        target_df <- cbind(tourn_df %>% select(-venue), course_df)
        return(target_df)
}

# function to get leaderboard for a given tournament
getGolfTournamentLeaderboard <- function(id, year, tour = "pga") {
        start_url <- paste0("http://api.sportradar.us/golf-", access_level, "2", "/leaderboard/", tour,"/", year, "/tournaments/", id, "/leaderboard.json?api_key=", golf_key)
        targetJSON <- getURL(start_url)
        target <- fromJSON(targetJSON)
        df <- data.frame(target$leaderboard)
        player_rounds <- NULL
        for(i in 1:length(df$rounds)){
                scores <- data.frame(df$rounds[[i]]) %>%
                        select(strokes, sequence) %>%
                        spread(sequence, strokes)
                score_df <- NULL
                score_df$one <- ifelse(is.null(scores$`1`) == FALSE, scores$`1`, NA)
                score_df$two <- ifelse(is.null(scores$`2`) == FALSE, scores$`2`, NA)
                score_df$three <- ifelse(is.null(scores$`3`) == FALSE, scores$`3`, NA)
                score_df$four <- ifelse(is.null(scores$`4`) == FALSE, scores$`4`, NA)
                player_rounds <- rbind(player_rounds, score_df)
        }
        player_rounds <- data.frame(player_rounds)
        colnames(player_rounds) <- str_c("round_", colnames(player_rounds), "_strokes")
        target_df <- cbind(df %>% select(-rounds), player_rounds)
        target_df <- target_df %>%
                mutate(tourn_id = id,
                       tourn_year = year,
                       tourn_tour = tour) %>%
                select(tourn_id, tourn_year, tourn_tour, everything())
        return(target_df)
}



