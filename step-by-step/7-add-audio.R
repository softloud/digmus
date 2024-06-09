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
melody_rendered <- animate(melody_animation,
     width = 1330, height = 882, 
     frame_time = t,
     duration = 10.2
     )


# take a look
melody_rendered

anim_save('data-raw/av/animation.mp4', melody_rendered)

# convert midi to mp3 using bash tool
create_mp3 <- 
    "timidity data-raw/midi/wikisource-contrapunctus-subject.midi -Ow -o - | ffmpeg -i - -acodec libmp3lame data-raw/av/audio.mp3"
# Run the command
system(create_mp3)

# Combine the video and audio files
av_encode_video("data-raw/av/animation.mp4", 
    audio = "data-raw/av/audio.mp3", output = "contrapunctus-i.mp4")


