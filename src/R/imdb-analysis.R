library(dplyr)
library(rjson)

top250.path <- "../../data/csv/imdb_top250.csv"
bot100.path <- "../../data/csv/imdb_bottom100.csv"

top250.data <- read.csv(file=top250.path)
bot100.data <- read.csv(bot100.path)

# split on comma
genres <- strsplit(as.character(top250.data$genres), ",")

# find the largest element
maxLen <- max(sapply(genres, length))

# fill in any blanks. The t() is to transpose the return from sapply
genres.new <- 
  t(sapply(genres, function(x)
    # append to x, NA's.  Note that if (0 == (maxLen - length(x))), then no NA's are appended 
    c(x, rep(NA, maxLen - length(x)))
  ))

genres.new <- as.data.frame(genres.new)

# add column names as necessary
colnames(genres.new) <- c("genre1", "genre2", "genre3", "genre4", "genre5", "genre6")

# Put it all back together
top250.data <- data.frame(top250.data, genres.new)
