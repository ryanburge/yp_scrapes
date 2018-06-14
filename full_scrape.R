
## Loading Packages
library(rvest)
library(ggmap)
library(tidyverse)

## Functions to Grab the Name and the Address and Number of Pages
get_name <- function(url) {
  url %>%
    read_html() %>%
    html_nodes("a.business-name") %>% 
    html_text()
}


get_address <- function(url) {
  url %>%
    read_html() %>%
    html_nodes("p.adr") %>% 
    html_text()
}


get_page <- function(url) {
  url %>%
    read_html() %>%
    html_nodes("div.pagination") %>% 
    html_text()
}


city <- "Seattle" ## Name of the City. If there is a space, add a + between the words. Los+Angeles
state <- "WA" ## State. Two letter abbrevation

yp <- paste0("https://www.yellowpages.com/search?search_terms=churches&geo_location_terms=",city,"%2C%20",state)

results <- sapply(yp, get_page)

dfs <- lapply(results, data.frame, stringsAsFactors = FALSE)
count <- bind_rows(dfs) %>% 
  rename(text = X..i..)

remove <- c("We found", "results12345Next")

count$text <- gsub(paste0(remove, collapse = "|"), "", count$text)

count <- count %>% 
  mutate(text = as.numeric(text)) %>% 
  mutate(pg = text/30) %>% 
  mutate(pg = ceiling(pg))

pages <- seq(0, count$pg, by = 1) 

yp <- paste0("https://www.yellowpages.com/search?search_terms=churches&geo_location_terms=",city,"%2C%20",state,"&page=", pages)

## Get the church name
results <- sapply(yp, get_name)

## Flatten into dataframe and clean up. Get to a tibble
dfs <- lapply(results, data.frame, stringsAsFactors = FALSE)
col_name <- bind_rows(dfs)

col_name <- col_name %>% 
  rename(name =  X..i..) %>% as.tibble() 

## Flatten into dataframe and clean up. Get to a tibble
results <- sapply(yp, get_address)

dfs <- lapply(results, data.frame, stringsAsFactors = FALSE)
col_add <- bind_rows(dfs)

col_add <- col_add %>% 
  rename(address =  X..i..) %>% as.tibble() 

## Bind the names df and the address df
name_add <- bind_cols(col_name, col_add)

write_csv(name_add, "D://yp_scrapes/need_geocodes/seattle_name_add.csv")

## For some reason it scrape the city mashed together with the address, this just takes the city name and adds a space before so it can geocode easier
# name_add$address <- gsub("Columbus,", " Columbus,", name_add$address)

## There are dragons here. DO NOT RUN UNTIL YOU ARE READY

## This is your google API key
register_google(key = "XXXXXXXX", account_type = "premium", day_limit = 100000)

## This will geocode the entire address column from the vector we just grabbed. It will take a while
# chi_geo1 <- name_add %>% head(1500)
# chi_geo2 <- name_add %>% tail(1451)
# 
# chi_geo_done1 <- geocode(chi_geo1$address)
# chi_geo_done2 <- geocode(chi_geo2$address)
# 
# all_chi_geo <- bind_rows(chi_geo_done1, chi_geo_done2)
# 
# chicago_done <- bind_cols(name_add, all_chi_geo)
# 
# write_csv(chicago_done, "chicago_complete.csv")



## This is to take the new geocodes lon and lat and mash that together with our full dataset
all_col <- bind_cols(name_add, col_geo) %>% as.tibble()


## Write this out to a csv
write_csv(col_total, "columbus_add.csv")




