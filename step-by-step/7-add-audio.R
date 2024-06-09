# Load the required library
library(av)
library(tidyverse)
library(gganimate)

# clean up av folder
clean_av <- "rm data-raw/av/*"
system(clean_av)


# Read the animation
melody_animation <- readr::read_rds('data-raw/step-output/melody_animation.rds')


# Animate and save the animation as a video
melody_mp4 <- animate(melody_animation,
     width = 1330, height = 882, 
     duration = 6,
     renderer = av_renderer("data-raw/av/animation.mp4"))


# take a look
melody_mp4

# convert midi to mp3 using bash tool
create_mp3 <- 
    "timidity data-raw/midi/wikisource-contrapunctus-subject.midi -Ow -o - | ffmpeg -i - -acodec libmp3lame data-raw/av/audio.mp3"
# Run the command
system(create_mp3)

# Combine the video and audio files
av_encode_video("data-raw/av/animation.mp4", 
    audio = "data-raw/av/audio.mp3", output = "contrapunctus-i.mp4")


