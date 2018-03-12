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
        if(target$status == "cancelled") {
                target_df <- NULL
                target_df$id <- id
                target_df$player_id <- "cancelled"
        } else {
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
                colnames(target_df)[which(colnames(target_df)=="id")] <- "player_id"
                tourn_id <- id
                target_df <- target_df %>%
                        mutate(tourn_id = tourn_id,
                               tourn_year = as.integer(year),
                               tourn_tour = tour) %>%
                        select(tourn_id, tourn_year, tourn_tour, everything()) %>%
                        mutate_if(is.list, as.numeric)
        }
        return(target_df)
}

# function for computing cumulative sd over time series such as tournament leaderboard     
cum_sd <- function(x){
        sds <- NULL
        for(i in seq_along(x)){
                y <- x[1:i][!is.na(x[1:i])]
                if(length(y) > 1) {
                        sds[i] <- sqrt((sum((y-mean(y, na.rm = T))^2))/(length(y)-1))
                } else {
                        sds[i] <- NA
                }
        }
        return(sds)
}

# function to sum variables while ignoring NAs
sum_vars <- function(x, y, ...) {
        vec <- c(x, y, ...)
        sum(vec[!is.na(vec)])
}

# function to update dataframe of tournament leaderboards with info from recently completed competitions

        # this function takes a df of leaderboard data that has been joined to tournament info data        

updateGolfLeaderboard <- function(tourn_df, tourn_list) {
        last_tournament_start <- max(tourn_df$start_date)
        last_tournament_end <- max(tourn_df$end_date)
        recent_tournaments <- tourn_list %>% 
                filter(start_date > last_tournament_start & end_date < today())
        if(length(recent_tournaments$id)==0) {
                print("No recent tournaments. Your tournament df is up to date.")
        } else {
                tourn_df <- tourn_df %>%
                        select(tourn_id:round_four_strokes) %>%
                        mutate_if(is.list, as.numeric)
                for(i in seq_along(recent_tournaments$id)){
                        lb <- getGolfTournamentLeaderboard(id = recent_tournaments$id[i], year = as.character(year(recent_tournaments$start_date[i])))
                        updated_scores <- bind_rows(tourn_df, lb)
                        Sys.sleep(1)
                }
                return(updated_scores)
        }
        
}
