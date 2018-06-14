
## Load packages
library(readr)
library(tidyverse)

## Load the Church YP Scrape
all <- read_csv("https://raw.githubusercontent.com/ryanburge/yp_scrapes/master/tidydata/total_churches.csv")

## Load the Denom names list
denom <- read_csv("https://raw.githubusercontent.com/ryanburge/yp_scrapes/master/denom.csv")

## Creating the numerator
denom_names <- all %>% filter(word %in% denom$word) %>% ## filter the entire YP scrape through the denom key words list
  distinct(name, .keep_all = TRUE) %>% ## some churches get pulled twice because they have two words that appear, this removes the duplicates
  group_by(place) %>% ## group by each city name
  count() # then count the number of churches in each city

## Now I need to figure out the denominator
all_names <- all %>% ## take the entire dataset again
  distinct(name, .keep_all = TRUE) %>%
  group_by(place) %>% ## group by the city name
  count() # count the total number of churches per city

## I need to combine the numerator with the denominator
bind_cols(denom_names, all_names) %>% ## binding these together by columns, luckily I can see that they are in the same order so a merge is unnecessary
  rename(total = n1) %>% ## because there are two n columns I need to rename the one that is the denominator
  select(-place1) %>% ## get rid of the second column of city names
  mutate(pct = n/total) ## Then divide the smaller n from the larger n and give that as a percentage 

