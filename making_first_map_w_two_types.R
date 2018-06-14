

denom <- read_csv("https://raw.githubusercontent.com/ryanburge/yp_scrapes/master/denom.csv")

tidy_col <- col_complete %>% 
  mutate(id = text) %>% 
  unnest_tokens(word, text)

col_w_den <- tidy_col %>% filter(word %in% denom$word) %>% ## filter the entire YP scrape through the denom key words list
  distinct(id, .keep_all = TRUE) %>% 
  mutate(type = "Denominational")

col_wo_den <- col_complete %>% filter(!text %in% col_w_den$id) %>% 
  mutate(type = "Non-Denominational")


type_col <- bind_rows(col_w_den, col_wo_den) 


qmap("franklin county, ohio", zoom = 11) +
  geom_point(
    aes(x = lon, y = lat, color = type),
    size = 2, alpha = 1,
    data = type_col) +
scale_color_npg()

ggsave(file="D://yp_scrapes/first_type_map.png", type = "cairo-png", width = 12, height = 12)
