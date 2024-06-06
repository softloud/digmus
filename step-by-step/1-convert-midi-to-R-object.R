# set midi file
midi_file = 'data-raw/midi/wikisource-contrapunctus-subject.midi'

source: https://en.wikipedia.org/wiki/The_Art_of_Fugue

# Prompts to set up a python environmnet for reticulate
library(pyramidi)

# Convert midi to an R object
midi_r <- pyramidi::MidiFramer$new(midi_file)

# Take a look at the contents
objects(midi_r)

# Thing we'll use

# notes
midi_r$df_notes_long

# tempo
midi_r$ticks_per_beat

saveRDS(midi_r$df_notes_long, 'data-raw/pyramidi_subject.rds')

saveRDS(midi_r$ticks_per_beat, 'data-raw/ticks_per_beat.rds')

# Development notes:
# 
# Originally this was in the package, but in the interest of reducing 
# dependencies, virtual env, for the workshop, put this in its own script.
# 
# Since am only using this one function from pyramidi, there are probably
# other ways to do this.