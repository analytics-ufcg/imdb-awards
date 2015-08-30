
library(dplyr)
library(ggplot2)
library(reshape2)
library(tidyr)
library(GGally)
#write.csv(oscar.data, oscar.path, row.names=F, quote=T)
oscar.path <- "../../data/csv/oscar_2000-2014.csv"
oscar.util.path <- "../../data/oscar_2000-2014.txt"
oscar.data <- read.csv(oscar.path)
oscar.util.data <- read.csv(oscar.util.path)

oscar.data <- cbind(oscar.data, oscar.util.data)

people.x.critic.data.wide <- oscar.data %>%
  transmute(title=movieTitle, people=movieRating, critic=movieMetascore/10, year=ano, winner=tipo)

people.x.critic.data.long <- people.x.critic.data.wide %>%
  gather(reviewer, rating, people:critic)

ggplot(people.x.critic.data.wide, aes(x=people, y=critic)) +
  geom_point(aes(colour=winner), size=3) +
  labs(x = "People Rating", y = "Critic Rating") +
  ggtitle(expression(atop("Povão vs Coxinhas", atop(italic("Ratings no IMDb"), "")))) +
  scale_colour_discrete(name="", breaks=c(0, 1), labels=c("Indicado", "Vencedor")) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
        panel.background = element_blank(), axis.line = element_line(colour = "black"))

ggplot((filter(people.x.critic.data.long, winner==1)), aes(x=year, y=rating, group=factor(reviewer))) +
  geom_point(aes(colour=factor(reviewer)), size=3) +
  labs(x = "Ano", y = "Rating") +
  ggtitle(expression(atop("Povão vs Coxinhas", atop(italic("Ganhadores do Oscar"), "")))) +
  scale_colour_discrete(name="Reviewer", breaks=c("people", "critic"), labels=c("Povão", "Coxinhas")) +
  geom_smooth(method="lm", aes(colour=factor(reviewer)), se=F) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
        panel.background = element_blank(), axis.line = element_line(colour = "black"))

oscar.rankings <- people.x.critic.data.wide %>%
  arrange(desc(people)) %>%
  mutate(peopleRanking=1:100) %>%
  arrange(desc(critic)) %>%
  mutate(criticRanking=1:100) %>%
  mutate(diff=abs(peopleRanking-criticRanking))

gpd.variance <- ggparcoord(data=arrange(oscar.rankings, desc(diff))[c(1:10),],
           columns = 6:7,
           groupColumn = 1,
           scale="globalminmax") +
  scale_y_reverse() +
  labs(x = "Rankings", y = "Position") +
  ggtitle(expression(atop("Rankings no IMDb", atop(italic("Filmes que mais mudaram"), "")))) +
  scale_colour_discrete(name="Movie Title")
gpd.variance

gpd.critic <- ggparcoord(data=arrange(oscar.rankings, criticRanking)[c(1:10),],
                           columns = 6:7,
                           groupColumn = 1,
                           scale="globalminmax") +
  scale_y_reverse() +
  labs(x = "Rankings", y = "Position") +
  ggtitle(expression(atop("Rankings no IMDb", atop(italic("Top 10 Coxinhas"), "")))) +
  scale_colour_discrete(name="Movie Title")
gpd.critic

gpd.people <- ggparcoord(data=arrange(oscar.rankings, peopleRanking)[c(1:10),],
                         columns = 6:7,
                         groupColumn = 1,
                         scale="globalminmax") +
  scale_y_reverse() +
  labs(x = "Rankings", y = "Position") +
  ggtitle(expression(atop("Rankings no IMDb", atop(italic("Top 10 Mortadelas"), "")))) +
  scale_colour_discrete(name="Movie Title")
gpd.people

########################################################################################################

top250.path <- "../../data/top250IMDB.csv"
top250.data <- read.csv(top250.path)














