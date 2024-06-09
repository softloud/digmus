# Prompts to set up a python environmnet for reticulate
library(pyramidi)

# set midi file
midi_path = 'data-raw/midi/wikisource-contrapunctus-subject.midi'
# source: https://en.wikipedia.org/wiki/The_Art_of_Fugue

# Convert midi to an R object
midi_r <- pyramidi::MidiFramer$new(midi_file)

# Take a look at the contents
objects(midi_r)

# Thing we'll use
midifile <- mido$MidiFile(midi_path)

ticks_per_beat <- midifile$ticks_per_beat

dfc = miditapyr$frame_midi(midifile)

head(dfc, 20)

df <- miditapyr$unnest_midi(dfc) %>% as_tibble()

head(df, 20)


dfm <- tab_measures(df, ticks_per_beat, c("m", "b", "t", "time")) 


dfm %>% 
    miditapyr$split_df() %->% c(df_meta, df_notes)

pyramidi_notes <- df_notes %>%
    dplyr::filter(type == 'note_on') %>%
        left_join(pyramidi::midi_defs)


saveRDS(pyramidi_notes, 'data-raw/step-output/pyramidi_subject.rds')
