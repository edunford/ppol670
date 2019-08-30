# Draw in Example ICEWS data from the SQL database
require(tidyverse)
require(dbplyr)

# Establish Connection
con = src_sqlite("~/Dropbox/Dataverse/ICEWS/icews_all.sqlite")

# Aggregate Query
cnt_counts <-
  con %>%
  tbl('public') %>%
  filter(str_detect(Source_Sectors,"Government"),Source_Sectors !="" ) %>%
  filter(Country !="") %>%
  group_by(Country,Event_Text) %>%
  count() %>%
  collect()



# Clean data
cnt_counts <-
  cnt_counts %>%
  ungroup %>%
  mutate(Event_Text = str_remove_all(Event_Text,",") %>%
           str_to_lower(.) %>% str_trim(.) %>% str_replace_all(.," ","_"))


#Expand into a "wide" data frame
cnt_wide <-
  cnt_counts %>%
  spread(Event_Text,n,fill=0) %>%
  rename_all(str_to_lower)



# Focus on Repression Related Dimensions
cnt_wide <-
  cnt_wide %>%
  select(country,contains("impose"))


# Save Data Frame
write_csv(cnt_wide,here::here('Lectures/week_09/Data/icews-repressive-all.csv'))
