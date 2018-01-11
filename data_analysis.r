library('tidyverse')
library('maps')
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

#Divide up the dataset according to the years
conflicts.one <- conflicts %>% filter(year < 2010)
conflicts.two <- conflicts %>% filter(year > 2010)

#Create a map of Kenya
map_kenya <- map_data('world') %>% filter(region == 'Kenya')

#Plot conflicts during the aftermath of the 2007 elections, size = number of deaths, color = type of violence
ggplot(data = conflicts.one) +
  geom_polygon(data = map_kenya, mapping = aes(x = long, y = lat, group=group), fill = NA, colour='black') +
  geom_point(mapping = aes(x=longitude, y=latitude, color=type_of_violence, size=best))

#Plot conflicts during the aftermath of the 2013 elections, size = number of deaths, color = type or violence
ggplot(data = conflicts.two) +
  geom_polygon(data = map_kenya, mapping = aes(x = long, y = lat, group=group), fill = NA, colour='black') +
  geom_point(mapping = aes(x=longitude, y=latitude, color=type_of_violence, size=best))

#Plot graph showing the number of deaths during the year after the 2007 elections
ggplot(data = conflicts.one) +
  geom_point(mapping = aes(x=date_start, y=best))

#Plot graph showing the number of deaths during the year after the 2013 elections
ggplot(data = conflicts.two) +
  geom_point(mapping = aes(x=date_start, y=best))
