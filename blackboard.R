library(pyramidi)
library(dplyr)
library(tidyr)
library(purrr)
library(ggplot2)
library(zeallot)

# set midi file
midi_path = 'data-raw/midi/wikisource-contrapunctus-subject.midi'

midifile <- mido$MidiFile(midi_path)

ticks_per_beat <- midifile$ticks_per_beat

dfc = miditapyr$frame_midi(midifile)

head(dfc, 20)

df <- miditapyr$unnest_midi(dfc) %>% as_tibble()

head(df, 20)


dfm <- tab_measures(df, ticks_per_beat, c("m", "b", "t", "time")) 


dfm %>% 
    miditapyr$split_df() %->% c(df_meta, df_notes)


melody_df <- 
  df_notes %>% 
    left_join(pyramidi::midi_defs) %>% 
    dplyr::filter(type == 'note_on') %>%
    dplyr::mutate(
      status = if_else(time == 0, 'on', 'off'),
      ii_note = (i_note + 1) %/% 2,
      note_name = stringr::str_remove(note_name, '4')
    ) %>% dplyr::select(ii_note, note, note_name, t, status) %>%
    pivot_wider(names_from = status, values_from = t) %>%
  arrange(on) %>%
  mutate(next_note = lead(note_name), 
    next_note = if_else(is.na(next_note), 'D', next_note)
  ) 