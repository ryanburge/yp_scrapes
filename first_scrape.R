library(rvest)
library(tidyverse)
library(tidytext)


get_table <- function(url) {
  url %>%
    read_html() %>%
    html_nodes("a.business-name") %>% 
    html_text()
}


## Columbus ####

pages <- seq(0, 41, by = 1)

yp <- paste0("https://www.yellowpages.com/search?search_terms=churches&geo_location_terms=Columbus%2C%20OH&page=", pages)

results <- sapply(yp, get_table)

dfs <- lapply(results, data.frame, stringsAsFactors = FALSE)
complete <- bind_rows(dfs)

columbus <- complete %>% 
  rename(text =  X..i..) %>% as.tibble() %>% 
  mutate(name = text) %>% mutate(place = "Columbus") %>% 
  unnest_tokens(word, text)

write_csv(columbus, "columbus.csv")


## Atlanta ####

pages <- seq(0, 78, by = 1)

yp <- paste0("https://www.yellowpages.com/search?search_terms=churches&geo_location_terms=Atlanta%2C%20GA&page=", pages)

results <- sapply(yp, get_table)

dfs <- lapply(results, data.frame, stringsAsFactors = FALSE)
complete <- bind_rows(dfs)

tidy <- complete %>% 
  rename(text =  X..i..) %>% as.tibble() %>% 
  mutate(name = text) %>% mutate(place = "Atlanta") %>% 
  unnest_tokens(word, text)

write_csv(tidy, "atlanta.csv")

## Charlotte ####

pages <- seq(0, 38, by = 1)

yp <- paste0("https://www.yellowpages.com/search?search_terms=churches&geo_location_terms=Charlotte%2C%20NC&page=", pages)


results <- sapply(yp, get_table)

dfs <- lapply(results, data.frame, stringsAsFactors = FALSE)
complete <- bind_rows(dfs)

tidy <- complete %>% 
  rename(text =  X..i..) %>% as.tibble() %>% 
  mutate(name = text) %>% mutate(place = "Charlotte") %>% 
  unnest_tokens(word, text)

write_csv(tidy, "charlotte.csv")


## Dallas ####

pages <- seq(0, 51, by = 1)

yp <- paste0("https://www.yellowpages.com/search?search_terms=churches&geo_location_terms=Dallas%2C%20TX&page=", pages)

results <- sapply(yp, get_table)

dfs <- lapply(results, data.frame, stringsAsFactors = FALSE)
complete <- bind_rows(dfs)

tidy <- complete %>% 
  rename(text =  X..i..) %>% as.tibble() %>% 
  mutate(name = text) %>% mutate(place = "Dallas") %>% 
  unnest_tokens(word, text)

write_csv(tidy, "dallas.csv")


## Philadelphia ####

pages <- seq(0, 92, by = 1)

yp <- paste0("https://www.yellowpages.com/search?search_terms=churches&geo_location_terms=Philadelphia%2C%20PA&page=", pages)

results <- sapply(yp, get_table)

dfs <- lapply(results, data.frame, stringsAsFactors = FALSE)
complete <- bind_rows(dfs)

tidy <- complete %>% 
  rename(text =  X..i..) %>% as.tibble() %>% 
  mutate(name = text) %>% mutate(place = "Philadelphia") %>% 
  unnest_tokens(word, text)

write_csv(tidy, "philadelphia.csv")


## Minneapolis ####

pages <- seq(0, 50, by = 1)

yp <- paste0("https://www.yellowpages.com/search?search_terms=churches&geo_location_terms=Minneapolis%2C%20MN&page=", pages)


results <- sapply(yp, get_table)

dfs <- lapply(results, data.frame, stringsAsFactors = FALSE)
complete <- bind_rows(dfs)

tidy <- complete %>% 
  rename(text =  X..i..) %>% as.tibble() %>% 
  mutate(name = text) %>% mutate(place = "Minneapolis") %>% 
  unnest_tokens(word, text)

write_csv(tidy, "minneapolis.csv")

## Denver ####

pages <- seq(0, 33, by = 1)

yp <- paste0("https://www.yellowpages.com/search?search_terms=churches&geo_location_terms=Denver%2C%20CO&page=", pages)

results <- sapply(yp, get_table)

dfs <- lapply(results, data.frame, stringsAsFactors = FALSE)
complete <- bind_rows(dfs)

tidy <- complete %>% 
  rename(text =  X..i..) %>% as.tibble() %>% 
  mutate(name = text) %>% mutate(place = "Denver") %>% 
  unnest_tokens(word, text)

write_csv(tidy, "denver.csv")


## Seattle ####

pages <- seq(0, 23, by = 1)

yp <- paste0("https://www.yellowpages.com/search?search_terms=churches&geo_location_terms=Seattle%2C%20WA&page=", pages)

results <- sapply(yp, get_table)

dfs <- lapply(results, data.frame, stringsAsFactors = FALSE)
complete <- bind_rows(dfs)

tidy <- complete %>% 
  rename(text =  X..i..) %>% as.tibble() %>% 
  mutate(name = text) %>% mutate(place = "Seattle") %>% 
  unnest_tokens(word, text)

write_csv(tidy, "seattle.csv")


## Phoenix ####

pages <- seq(0, 41, by = 1)

yp <- paste0("https://www.yellowpages.com/search?search_terms=churches&geo_location_terms=Phoenix%2C%20AZ&page=", pages)

results <- sapply(yp, get_table)

dfs <- lapply(results, data.frame, stringsAsFactors = FALSE)
complete <- bind_rows(dfs)

tidy <- complete %>% 
  rename(text =  X..i..) %>% as.tibble() %>% 
  mutate(name = text) %>% mutate(place = "Phoenix") %>% 
  unnest_tokens(word, text)

write_csv(tidy, "phoenix.csv")

## LA ####

pages <- seq(0, 68, by = 1)

yp <- paste0("https://www.yellowpages.com/search?search_terms=churches&geo_location_terms=Los+Angeles%2C%20CA&page=", pages)

results <- sapply(yp, get_table)

dfs <- lapply(results, data.frame, stringsAsFactors = FALSE)
complete <- bind_rows(dfs)

tidy <- complete %>% 
  rename(text =  X..i..) %>% as.tibble() %>% 
  mutate(name = text) %>% mutate(place = "Los Angeles") %>% 
  unnest_tokens(word, text)

write_csv(tidy, "la.csv")


## Chicago ####

pages <- seq(0, 97, by = 1)

yp <- paste0("https://www.yellowpages.com/search?search_terms=churches&geo_location_terms=Chicago%2C%20IL&page=", pages)

results <- sapply(yp, get_table)

dfs <- lapply(results, data.frame, stringsAsFactors = FALSE)
complete <- bind_rows(dfs)

tidy <- complete %>% 
  rename(text =  X..i..) %>% as.tibble() %>% 
  mutate(name = text) %>% mutate(place = "Chicago") %>% 
  unnest_tokens(word, text)

write_csv(tidy, "chicago.csv")


