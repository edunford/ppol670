# Data used in the lecture: all code is in slides, the following
# script lays out how the `pol` and `pol2` data objects were
# generated.

require(tidyverse)

dat <- read_csv('data_from_lecture/dem-gdp-data.csv')


# Create `pol` data object used in the examples.
pol = dat %>%
  mutate(polity = round(polity)) %>%
  mutate(type = case_when(polity >= 6 ~ "Democracy",
                          polity <=-6 ~ "Autocracy",
                          T ~ "Competitive Authoritarian")) %>%
  filter(year >=1990)
head(pol)


# Create `pol2` data object used in the examples.

pol2 = dat %>%
  filter(country %in% c("Chile","Argentina","Ecuador",
                        "Brazil","Venezuela","Paraguay",#"Guyana","Suriname",
                        "Columbia","Peru","Bolivia")) %>%
  filter(year>=1850)
head(pol2)

# See code in slides to replicate visualizations.
