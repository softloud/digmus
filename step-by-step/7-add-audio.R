# Load the required library
library(av)

# Read the animation
melody_animation <- readr::read_rds('data-raw/melody_animation.rds')


# Animate and save the animation as a video
animate(graph_animation
     width = 1330, height = 882, 
     duration = 6528,
     renderer = av_renderer("data-raw/animation.mp4"))


command <- 
    "timidity data-raw/midi/wikisource-contrapunctus-subject.midi -Ow -o - | ffmpeg -i - -acodec libmp3lame data-raw/audio.mp3"
# Run the command
system(command)

# Combine the video and audio files
av_encode_video("output_animation.mp4", 
    audio = "midi/wiki-subject-vlc-convert.mp3", output = "final_output.mp4")


