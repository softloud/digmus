library(tidyverse) # grabbag of datasci tools
library(gt) # for tables
library(gganimate)
library(ggraph)
library(tidygraph)

# objective: animate a directed graph of music, ordered by note, 
# each time a note is played, an edge is added to digraph in sequence
# labelled with text labels on nodes, for debugging
# time the face transitions of the animation by the music
# not sure if this involves using both duration and beat or tick it falls on
# ideally it'd be nice if the edges drew according to duration 

graphdat <- read_csv('mididf.csv')

graphdat |> gt() |> tab_header(
        md('![](https://upload.wikimedia.org/score/k/u/kuqreev9vn17n29y7rcsbjjw752x7we/kuqreev9.png)'))

# graphdat columns

# note - midi note by number, accounts for octave
# note_index - the order the notes appear in the music
# beat - 16 beats in a bar, indexed from 0, representing semiquaver beats
# ticks - total ticks passed, keeping this as mfr has a ticks per beat object
# think might need this for transition to sync with midi audio
# mfr$ticks_per_beat
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


