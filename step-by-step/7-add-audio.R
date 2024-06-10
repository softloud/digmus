# Load the required library
library(tidyverse)
library(gganimate)

# convert midi to mp3 using bash tool
create_mp3 <- 
    "timidity midi/wikisource-contrapunctus-subject.midi -Ow -o - | ffmpeg -i - -acodec libmp3lame outputs/av/audio.mp3"

# Run the command
system(create_mp3)

add_audio <- "ffmpeg -i outputs/av/animation.mp4 -i outputs/av/audio.mp3 -c:v copy -c:a aac -strict experimental -shortest contrapunctus-i.mp4"
system(add_audio)

