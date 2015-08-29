library(dplyr)
library(rjson)

top250.path <- "../../data/csv/imdb_top250.csv"
bot100.path <- "../../data/csv/imdb_bottom100.csv"

top250.data <- read.csv(file=top250.path)
bot100.data <- read.csv(bot100.path)
