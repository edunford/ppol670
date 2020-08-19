# Slack logo Icon for class

require(tidyverse)

lab_dat <-
  tibble(x = 0,
         y = 0,
         label = '670')

# Generate random walks
random_walk <- function(N,group){
  tibble(time = 1:N,
         steps = ifelse(rbinom(N,1,.5)==0,-1,1)) %>%
    mutate(steps=cumsum(steps),
           group=group)
}

# Generate RW data
G = 100
N=1000
out = c()
for(i in 1:G){
  out = bind_rows(out,random_walk(N,i))
}


ppol670_icon <-
  bind_rows(out %>% mutate(time = -1*time,group=100*group),
            out) %>%
  ggplot(aes(time,steps,group=group,color=abs(time))) +
  geom_path(alpha=.5,show.legend = F) +
  scale_color_viridis_c(option="magma",begin = 1,end=0) +
  geom_text(data=lab_dat,aes(x,y,label=label),size=100,inherit.aes = F,
            color="black",family="serif") +
  theme_void()

# Export
ggsave("syllabus/slack_icon.png",ppol670_icon,width = 10,height=10)
