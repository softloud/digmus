library(tidyverse)
library(gganimate)

# get graph plot
melody_graph_plot <- read_rds('data-raw/melody_graph_plot.rds')

# use gganimate on ggraph object 
melody_animation <- 
    melody_graph_plot +
    transition_time(tick) +
    shadow_mark()

melody_animation

readr::write_rds(melody_animation, 'data-raw/melody_animation.rds')
