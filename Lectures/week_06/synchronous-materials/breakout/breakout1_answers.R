# Scrape the Presidential Debates off of
# https://en.wikipedia.org/wiki/United_States_presidential_debates

require(tidyverse)
require(rvest)

url <-  "https://en.wikipedia.org/wiki/United_States_presidential_debates"


# Download the website
raw <- read_html(url)


# Q1: Scrape all the text from the wiki page. Collapse content into a single string.
  content <-
    raw %>%
    html_nodes("p") %>%
    html_text() %>%
    paste0(.,collapse=" ")


# Q2: Scrape all the references from the wikipedia page and store in a tibble
# data.frame

  citations <-
    raw %>%
    html_nodes('cite') %>%
    html_text() %>%
    tibble(citations = .)


# Q3: Download and clean the table after the "Timeline" header on the page.
# Create a tidy data frame that only has the election date and the presidential candidates

  tables <- raw %>% html_table(fill=T)
  timeline <- tables[[3]]

  # Target
  debates <-
    as_tibble(timeline[,c(1,3)]) %>%
    janitor::clean_names() %>%
    filter(presidential_debates != "None")


  # Further way we could clean this.
  debates2 <-
    debates %>%
    separate(presidential_debates,into = c("candidate","party"),sep="\\(") %>%
    pivot_wider(names_from = party,values_from=candidate) %>%
    janitor::clean_names() %>%
    rename(republican_candidate = r, democratic_candidate = d, independent_candidate = i)
