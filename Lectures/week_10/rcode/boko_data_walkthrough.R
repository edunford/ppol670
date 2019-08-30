
require(tidyverse)
require(tidytext)

bh = read_csv("~/Dropbox/Research/ONGOING/EOS/raw-data/boko-haram_eos-all_extracted-10-04-2018.csv")


bh2 <-
  bh %>%
  mutate(date = as.Date(publication_date),
         source_country = str_to_title(source_country),
         source_country = countrycode::countrycode(source_country,"country.name","country.name"),
         ccode = countrycode::countrycode(source_country,"country.name","cowc"),
         month=lubridate::round_date(date,unit = "month")) %>%
  select(story_title=title,date,month,
         source_name,ccode,source_country,
         article)
dim(bh2)



# Reporting time series
bh2 %>%
  count(month) %>%
  ggplot(aes(month,n)) +
  geom_point() +
  geom_line()

# Which month had the most news stories
bh2 %>%
  count(month,sort=T) %>%
  top_n(10)

#  alot of stories in 2014 (Chebok school girl)
set.seed(12345)
bh2 %>%
  filter(month=="2014-05-01") %>%
  sample_n(1) %>%
  .$article %>%
  cat



# Convert to tidy textual framework

bh3 <-
  bh2 %>%
  filter(month=="2014-05-01") %>%
  unnest_tokens(word,article) %>%
  anti_join(stop_words,by='word') %>% # Drop stop words
  filter(!word %in% c("april","2014","nigeria","nigerian","nigeria's")) %>%
  filter(!str_detect(word,"[:punct:]"))

# Count term frequencies
bh3 %>%
  count(word,sort=T) %>%
  top_n(n,n = 25) %>%
  mutate(word = fct_inorder(word,n)) %>%
  ggplot(aes(word,rev(n))) +
  geom_col() +
  coord_flip()

# Compare the differences between local and international reporting
bh3 %>%
  mutate(from = ifelse(source_country=="Nigeria","local","international"),
         from = ifelse(is.na(from),"No Info",from)) %>%
  group_by(from) %>%
  count(word,sort=T) %>%
  # arrange(desc(n)) %>%
  top_n(25) %>%
  ggplot(aes(fct_reorder(word,n),n,group=from)) +
  geom_col() +
  coord_flip() +
  facet_wrap(~from,scales="free")



