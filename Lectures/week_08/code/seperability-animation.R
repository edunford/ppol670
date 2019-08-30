# Seperability Animation

require(tidyverse)
require(gganimate)
require(ggthemes)


# Simulate data...
set.seed(1234)
N = 5000
x1 <-  runif(N)
x2 <-  runif(N)


D <-
  bind_rows(
    tibble(x1,x2) %>%
      mutate(id = row_number(),
             y = as.numeric(x1 + x1^2 + x2 + x2^2 > 2),
             type = "High Separability"),
    tibble(x1,x2) %>%
      mutate(id = row_number(),
             y = as.numeric(runif(N)>.5),
             type = "Low Separability")
  )


anim_base <-
  D %>%
  ggplot(aes(x1,x2,color=factor(y))) +
  geom_point(size=3,alpha=.7) +
  theme_bw() +
  scale_color_colorblind()+
  labs(color="",title = "{closest_state}") +
  theme(text = element_text(size=24),
        legend.position = "top",
        legend.text = element_text(size=20),
        title = element_text(hjust=.5)) +
  transition_states(states = type,transition_length = 3,state_length = 4) +
  enter_fade() +
  exit_fade()

animated_plot <- animate(anim_base,nframes=75)

anim_save(animated_plot,file = here::here('Lectures/week_08/Figures/seperability.gif'))
