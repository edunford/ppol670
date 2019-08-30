

sunk = as.data.frame(Titanic)

sunk %>%
  ggplot(aes(Age,Class,fill=log(Freq))) +
  geom_tile(color="white") +
  geom_color()
  facet_wrap(~Sex)



pol = read_csv(here::here("Lectures/week_04/R-code/dem-gdp-data.csv")) %>%
  mutate(polity = round(polity)) %>%
  mutate(type = case_when(polity >= 6 ~ "Democracy",
                          polity <=-6 ~ "Autocracy",
                          T ~ "Competitive Authoritarian")) %>%
  filter(year >=1990)




# Example 1 ---------------------------------------------------------------

pol %>%
  ggplot(aes(polity,lngdppc)) +
  geom_point()


pol %>%
  ggplot(aes(factor(polity),lngdppc)) +
  geom_jitter(alpha=.2)

pol %>%
  ggplot(aes(factor(polity),lngdppc)) +
  geom_jitter(alpha=.2,color="steelblue")


pol %>%
  ggplot(aes(factor(polity),lngdppc)) +
  geom_boxplot(alpha=.2,color="steelblue")

pol %>%
  ggplot(aes(factor(polity),lngdppc)) +
  geom_boxplot(alpha=.2,color="steelblue") +
  theme_minimal()


pol %>%
  ggplot(aes(factor(polity),lngdppc)) +
  geom_boxplot(alpha=.2,color="steelblue") +
  theme_minimal() +
  facet_wrap(~type,scales="free_x")


pol %>%
  ggplot(aes(factor(polity),lngdppc,fill=type)) +
  geom_boxplot(alpha=.2,color="grey30") +
  theme_minimal() +
  facet_wrap(~type,scales="free_x")


pol %>%
  ggplot(aes(factor(polity),lngdppc,fill=type)) +
  geom_boxplot(alpha=.2,color="grey30") +
  theme_minimal() +
  facet_wrap(~type,scales="free_x") +
  theme(legend.position = "bottom")


pol %>%
  ggplot(aes(factor(polity),lngdppc,fill=type)) +
  geom_boxplot(alpha=.2,color="grey30") +
  theme_minimal() +
  facet_wrap(~type,scales="free_x") +
  scale_fill_manual(values=c("darkred","grey40","steelblue")) +
  labs(x="Polity Score",y="Log GDP per capita",fill="") +
  theme(legend.position = "bottom")


pol %>%
  ggplot(aes(factor(polity),lngdppc,fill=type)) +
  geom_boxplot(alpha=.2,color="grey30") +
  theme_minimal() +
  facet_wrap(~type,scales="free_x") +
  scale_fill_manual(values=c("darkred","grey40","steelblue")) +
  labs(x="Polity Score",y="Log GDP per capita",fill="",
       title="Regime type on Economic Development",
       subtitle="Data on polity and GDP per capita from 1990 - 2016") +
  theme(legend.position = "bottom")


pol %>%
  ggplot(aes(factor(polity),lngdppc,fill=type)) +
  geom_boxplot(alpha=.2,color="grey30") +
  theme_minimal() +
  facet_wrap(~type,scales="free_x") +
  scale_fill_manual(values=c("darkred","grey40","steelblue")) +
  labs(x="Polity Score",y="Log GDP per capita",fill="",
       title="Regime type on Economic Development",
       subtitle="Data on polity and GDP per capita from 1990 - 2016") +
  theme(legend.position = "bottom",
        plot.title = element_text(hjust=.5),
        plot.subtitle = element_text(hjust=.5))


pol %>%
  ggplot(aes(factor(polity),lngdppc,fill=type)) +
  geom_boxplot(alpha=.2,color="grey30") +
  theme_minimal() +
  facet_wrap(~type,scales="free_x") +
  scale_fill_manual(values=c("darkred","grey40","steelblue")) +
  labs(x="Polity Score",y="Log GDP per capita",fill="",
       title="Regime type on Economic Development",
       subtitle="Data on polity and GDP per capita from 1990 - 2016") +
  theme(legend.position = "bottom",
        plot.title = element_text(hjust=.5),
        plot.subtitle = element_text(hjust=.5),
        panel.spacing.x = unit(15,units="mm"))



# Example 2 ---------------------------------------------------------------


pol2 = read_csv(here::here("Lectures/week_04/R-code/dem-gdp-data.csv")) %>%
  filter(country %in% c("Chile","Argentina","Ecuador",
                        "Brazil","Venezuela","Paraguay",#"Guyana","Suriname",
                        "Columbia","Peru","Bolivia")) %>%
  filter(year>=1850)


pol2 %>%
  ggplot(aes(country,year)) +
  geom_tile()

pol2 %>%
  ggplot(aes(country,year)) +
  geom_tile(aes(fill=polity))

pol2 %>%
  ggplot(aes(country,year)) +
  geom_tile(aes(fill=polity)) +
  scale_fill_gradient2(low="darkred",mid = "white",high="darkblue")


pol2 %>%
  ggplot(aes(country,year)) +
  geom_tile(aes(fill=polity)) +
  scale_fill_gradient2(low="darkred",mid = "white",high="darkblue") +
  coord_flip()

pol2 %>%
  ggplot(aes(country,year)) +
  geom_tile(aes(fill=polity)) +
  scale_fill_gradient(low = "#2d234c", high = "#ffd449") +
  coord_flip()


pol2 %>%
  ggplot(aes(country,year)) +
  geom_tile(aes(fill=polity)) +
  scale_fill_gradient(low = "#ffd449", high = "#2d234c") +
  coord_flip() +
  theme_tufte()


pol2 %>%
  mutate(country=fct_rev(country)) %>%
  ggplot(aes(country,year)) +
  geom_tile(aes(fill=polity)) +
  scale_fill_gradient(low = "#ffd449", high = "#2d234c") +
  coord_flip() +
  theme_tufte()



pol2 %>%
  mutate(country=fct_rev(country)) %>%
  ggplot(aes(country,year)) +
  geom_tile(aes(fill=polity)) +
  scale_fill_gradient(low = "#ffd449", high = "#2d234c") +
  coord_flip() +
  theme_tufte() +
  labs(fill="Regime Type",y="Country",x="Year")



# Example 3 (Alternative way of showing the same thing) -------------------

pol2 %>%
  ggplot(aes(year,polity,group=country)) +
  geom_line(color="grey20",size=.75) +
  facet_wrap(~country,ncol=2) +
  theme_fivethirtyeight() +
  labs(title="The Path to Democracy",
       subtitle = "Democratization and democratic backsliding in South America* from 1850 to 2016",
       caption = "* Only South American countries with complete data from 1850 to 2016 are shown",
       y="Polity",x="Year") +
  theme(axis.title = element_text(),
        plot.caption = element_text(hjust=0))







