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

ggplot(data = conflicts.one) +
  geom_polygon(data = map_data('kenya'), mapping = aes(x = long, y = lat, group=group), fill = NA, colour='black')

ggplot(data = conflicts.one) +
  geom_point(mapping = aes(x=date_start, y=best))

ggplot(data = conflicts.two) +
  geom_point(mapping = aes(x=date_start, y=best))
