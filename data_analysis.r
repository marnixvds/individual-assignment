library('tidyverse')
library('maps')
library("dplyr")

#Kenya election conflicts analysis

#Read in and check out the data
conflicts <- read.csv('preprocessed_data.csv')
summary(conflicts)

#Are dates formatted correctly?
conflicts$date_start[0]
#No, so format...
as.Date(conflicts$date_start, '%Y-%m-%d') #Checkout
conflicts$date_start <- as.Date(conflicts$date_start, '%Y-%m-%d') #Execute
conflicts$date_end <- as.Date(conflicts$date_end, '%Y-%m-%d') #Times 2

#For a nice graph, the type_of_violence variable needs to be converted to a factor
conflicts$type_of_violence <- factor(conflicts$type_of_violence)

#Divide up the dataset according to the years
conflicts.one <- conflicts %>% filter(year < 2010)
conflicts.two <- conflicts %>% filter(year > 2010)

#To fill in the number of conflicts and deaths in a table, calculate those
amount.one <- nrow(conflicts.one)
amount.two <- nrow(conflicts.two)
deaths.one <- sum(conflicts.one$best)
deaths.two <- sum(conflicts.two$best)

#Create a map of Kenya
map_kenya <- map_data('world') %>% filter(region == 'Kenya')

#Plot conflicts during the aftermath of the 2007 elections, size = number of deaths, color = type of violence
ggplot(data = conflicts.one) +
  geom_polygon(data = map_kenya, mapping = aes(x = long, y = lat, group=group), fill = NA, colour='black') +
  geom_point(mapping = aes(x=longitude, y=latitude, color=type_of_violence, size=best)) +
  labs(x = "Longitude", y = "Latitude", color = "Type of conflict", size = "Deaths")

#Plot conflicts during the aftermath of the 2013 elections, size = number of deaths, color = type or violence
ggplot(data = conflicts.two) +
  geom_polygon(data = map_kenya, mapping = aes(x = long, y = lat, group=group), fill = NA, colour='black') +
  geom_point(mapping = aes(x=longitude, y=latitude, color=type_of_violence, size=best)) +
  labs(x = "Longitude", y = "Latitude", color = "Type of conflict", size = "Deaths")

#Plot both elections on one map
ggplot() +
  geom_polygon(data = map_kenya, mapping = aes(x = long, y = lat, group = group), fill = NA, colour = 'black') +
  geom_point(data = conflicts.one, mapping = aes(x=longitude, y=latitude, size=best, color='2007')) +
  geom_point(data = conflicts.two, mapping = aes(x=longitude, y=latitude, size=best, color='2013')) +
  labs(x = "Longitude", y = "Latitude", color = "Elections", size = "Deaths")

#Group deaths by date
conflicts.one.grouped <- conflicts.one %>% group_by(date_start) %>% summarise(sum(best))
conflicts.one.grouped <- rename(conflicts.one.grouped, sum = 'sum(best)') #Rename column to use it in ggplot
conflicts.two.grouped <- conflicts.two %>% group_by(date_start) %>% summarise(sum(best))
conflicts.two.grouped <- rename(conflicts.two.grouped, sum = 'sum(best)') #Rename column again

#Plot graph showing the number of deaths during the year after the 2007 elections
ggplot(data = conflicts.one.grouped) +
  geom_point(mapping = aes(x=date_start, y=sum)) +
  geom_smooth(mapping = aes(x=date_start, y=sum), linetype = 'dashed', se = FALSE) +
  labs(x = "Date", y = "Number of deaths") +
  ylim(0, 180)

#Plot graph showing the number of deaths during the year after the 2013 elections
ggplot(data = conflicts.two.grouped) +
  geom_point(mapping = aes(x=date_start, y=sum)) +
  geom_smooth(mapping = aes(x=date_start, y=sum), linetype = 'dashed', se = FALSE) +
  labs(x = "Date", y = "Number of deaths") +
  ylim(0, 180)

#Tryout: Two over eachother
ggplot() +
  geom_point(data = conflicts.one.grouped, mapping = aes(x=date_start, y=sum)) +
  geom_smooth(data = conflicts.one.grouped, mapping = aes(x=date_start, y=sum), linetype = 'dashed', se = FALSE) +
  geom_point(data = conflicts.two.grouped, mapping = aes(x=date_start, y=sum)) +
  geom_smooth(data = conflicts.two.grouped, mapping = aes(x=date_start, y=sum), linetype = 'dashed', se = FALSE) +
  labs(x = "Date", y = "Number of deaths")
#Looks ugly, so no!  
