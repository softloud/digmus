library(gganimate)

# get graph plot
melody_graph_plot <- readr::read_rds('outputs/step-output/melody_graph_plot.rds')

# use gganimate on ggraph object 
melody_animation <- 
    melody_graph_plot +
    transition_time(t) +
    shadow_mark()

melody_animation

# Animate and save the animation as a video
melody_rendered <- animate(
  melody_animation,
  width = 1330, 
  height = 882, 
  renderer = av_renderer('outputs/av/animation.mp4'),
  frame_time = t,
  duration = 10.2
)

# take a look
melody_rendered
