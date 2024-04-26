library(tidyverse) # grabbag of datasci tools
library(gt) # for tables
library(pyramidi)
library(gganimate)
library(ggraph)
library(tidygraph)

# objective: animate a directed graph of music, ordered by note, 
# each time a note is played, an edge is added to digraph in sequence
# labelled with text labels on nodes, for debugging
# time the face transitions of the animation by the music
# not sure if this involves using both duration and beat or tick it falls on
# ideally it'd be nice if the edges drew according to duration 


# import the subject from Contrapunctus I as a midiframer object
mfr <- MidiFramer$new('midi/wikisource-contrapunctus-subject.midi')


# this provides a bunch of objects
mfr

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

# graphdat columns

# note - midi note by number, accounts for octave
# note_index - the order the notes appear in the music
# beat - 16 beats in a bar, indexed from 0, representing semiquaver beats
# ticks - total ticks passed, keeping this as mfr has a ticks per beat object
# think might need this for transition to sync with midi audio
mfr$ticks_per_beat
# d_minor_text - the text label for d minor to label the nodes by
# next_note_text - note the edge needs to connect to
# next_note - numeric representation of note, accounts for octave

# linear graph object
graphdat %>%
    select(from = d_minor_text, to = next_note_text) |>
    as_tbl_graph() |>
    ggraph(layout = 'linear') +
    geom_edge_fan() + 
    geom_node_point(size = 10) +
    theme_graph(
        background = 'white'
    ) 

# with animation
graphdat %>%
    select(from = d_minor_text, to = next_note_text) |>
    as_tbl_graph() |>
    ggraph(layout = 'linear') +
    geom_edge_fan() + 
    geom_node_point(size = 10) +
    theme_graph(
        background = 'white'
    ) +
    transition_time(from)

# how to add text labels to nodes so I can check it's doing what I want it to?

# how to sort the nodes by the note column?

# how to animate by beat the note falls on?

# how to add the midi audio to the output?

# how to set the tempo to the midi tempo?

# unsolved for later


