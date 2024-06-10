# Prompts to set up a python environmnet for reticulate
library(pyramidi)
library(magrittr)
library(zeallot)

# set midi file
midi_path = 'midi/wikisource-contrapunctus-subject.midi'
# source: https://en.wikipedia.org/wiki/The_Art_of_Fugue

# Thing we'll use
midifile <- mido$MidiFile(midi_path)

ticks_per_beat <- midifile$ticks_per_beat

dfc = miditapyr$frame_midi(midifile)

head(dfc, 20)

df <- miditapyr$unnest_midi(dfc) %>% tibble::as_tibble()

head(df, 20)


dfm <- tab_measures(df, ticks_per_beat, c("m", "b", "t", "time")) 


dfm %>% 
    miditapyr$split_df() %->% c(df_meta, df_notes)

pyramidi_notes <- df_notes %>%
    dplyr::filter(type == 'note_on') %>%
        dplyr::left_join(pyramidi::midi_defs)


saveRDS(pyramidi_notes, 'outputs/step-output/pyramidi_notes.rds')
