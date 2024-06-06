
# use gganimate on ggraph object 
graph_animation <- ggraph_obj +
    transition_time(tick) +
    shadow_mark()


# Load the required library
library(av)



# Animate and save the animation as a video
animate(graph_animation
     width = 1330, height = 882, 
     duration = 6528,
     renderer = av_renderer("output_animation.mp4"))

# Combine the video and audio files
av_encode_video("output_animation.mp4", audio = "midi/wiki-subject-vlc-convert.mp3", output = "final_output.mp4")


# Load the required library
library(av)
# Define the command as a string
command <- "ffmpeg -i output_animation.mp4 -i midi/wiki-subject-vlc-convert.mp3 -c:v copy -c:a aac -shortest final_output.mp4"

# Run the command
system(command)
# Combine the audio and video files