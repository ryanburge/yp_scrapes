library(rvest)
library(ggmap)
library(tidyverse)

get_address <- function(url) {
  url %>%
    read_html() %>%
    html_nodes("p.adr") %>% 
    html_text()
}

pages <- seq(0, 41, by = 1)

yp <- paste0("https://www.yellowpages.com/search?search_terms=churches&geo_location_terms=Columbus%2C%20OH&page=", pages)

results <- sapply(yp, get_address)

dfs <- lapply(results, data.frame, stringsAsFactors = FALSE)
complete <- bind_rows(dfs)

columbus <- complete %>% 
  rename(address =  X..i..) %>% as.tibble() %>% 
   mutate(place = "Columbus")

columbus$address <- gsub("Columbus,", " Columbus,", columbus$address)


register_google(key = "AIzaSyAX0VFzpus9E88SZQrWiQfn5GoA5RkypOM")

col_geo <- geocode(columbus$address)


col_add <- bind_cols(columbus, col_geo)




get_name <- function(url) {
  url %>%
    read_html() %>%
    html_nodes("a.business-name") %>% 
    html_text()
}

results <- sapply(yp, get_name)

dfs <- lapply(results, data.frame, stringsAsFactors = FALSE)
complete <- bind_rows(dfs)

columbus <- complete %>% 
  rename(text =  X..i..) %>% as.tibble() %>% 
  mutate(name = text) %>% mutate(place = "Columbus") %>% 
  unnest_tokens(word, text)


col_total <- bind_cols(columbus, col_add)



write_csv(col_total, "columbus_add.csv")




