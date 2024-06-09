library(tidyverse) # grabbag of datasci tools
library(gt) # for tables
library(tidygraph) # for graph objects in R
library(ggraph) # for plotting graphs

# get the data #
melody_df <- readRDS('data-raw/step-output/melody_df.rds')

melody_graph <- 
    melody_df %>%
     arrange(on) %>%
    mutate(next_note = lead(note_name), 
    next_note = if_else(is.na(next_note), 'D', next_note)
  )  %>% 
    select(from = note_name, to = next_note, note, t = on) %>%
    arrange(note) %>%
    as_tbl_graph()

melody_graph

write_rds(melody_graph, 'data-raw/step-output/melody_graph.rds')
