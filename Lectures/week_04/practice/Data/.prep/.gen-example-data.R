# Generate fake data...
set.seed(1234)
  
data_1 <- tibble(state = sample(state.name,25),
                 year = 2006,
                 dogs_per_1000 = round(rnorm(25,10,4),2))

data_2 <- tibble(STATE = sample(state.name,40),
                 YEAR = 2006,
                 beer_tax = round(runif(40,.01,.30),2))

data_3 <- bind_rows(
  tibble(state_name = state.name,
         date_year = 2005,
         traffic_per_1000 = round(rnorm(length(state.name),5,3),2)),
  tibble(state_name = state.name,
         date_year = 2006,
         traffic_per_1000 = round(rnorm(length(state.name),5,3),2))
)

# Export to data file
write_csv(data_1,path = "Data/states-dogs-data.csv")
write_csv(data_2,path = "Data/states-beer-data.csv")
write_csv(data_3,path = "Data/states-traffic-data.csv")
