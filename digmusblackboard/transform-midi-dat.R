library(pyramidi)
library(tidyverse) # grabbag of datasci tools
library(tuneR)

# import the subject from Contrapunctus I as a midiframer object
mfr <- MidiFramer$new('midi/wikisource-contrapunctus-subject.midi')


# this provides a bunch of objects


# I think the most useful object for this is
mfr$df_notes_long

# select relevant columns
graphdat_raw <- 
    mfr$df_notes_long |>
        select(note, b, ticks)

head(graphdat_raw)

# create labels

d_minor_text <- c('C#', 'D', 'E', 'F', 'G', 'A', 'Bb')

# will leave engineering labelling for another day
# for now, hardcoding the key

d_minor <- tibble(
    d_minor_text,
    note = c(61, 62, 64, 65, 67, 69, 70)
)

d_minor

# create the dataframe to transform into a graph df
# engineered this too many times, but still not 

graphdat <-
    graphdat_raw %>%
    mutate(note_index = rep(1:12, each = 2)) %>%
    group_by(note, note_index) %>%
    reframe(beat = min(b), tick = min(ticks)) %>%
    arrange(note_index) %>%
    left_join(d_minor, by = 'note') %>%
    {. ->> tmp} %>%
    mutate(next_note_text = c(.$d_minor_text[2:12], 'D'),
        next_note = c(.$note[2:12], 64))
rm(tmp)

graphdat

write_csv(graphdat, 'mididf.csv')

midi_duration <-  max(mfr$df_notes_long$ticks)
