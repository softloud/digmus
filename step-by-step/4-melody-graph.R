library(tidyverse) # grabbag of datasci tools
library(gt) # for tables
library(tidygraph) # for graph objects in R
library(ggraph) # for plotting graphs

# get the data #
melody_df <- readRDS('outputs/step-output/melody_df.rds')

# Then apply your existing code
melody_graphable <- melody_df %>%
  arrange(on) %>%
  mutate(
    from = note_name,
    to = lead(note_name),
    t = off
  ) %>%
  dplyr::filter(!is.na(to)) %>%
  select(from, to, t, note) %>%
  # get start note
  rbind(
    melody_df %>%
      mutate(
        from = note_name,
        to = note_name,
        t = 0
      ) %>%
      select(from, to, t, note) %>%
      slice(1)
  ) %>%
  # get end note
  rbind(
    melody_df %>%
      mutate(
        from = note_name,
        to = note_name,
        t = off
      ) %>%
      select(from, to, t, note) %>%
      slice(n())
  ) %>%
  arrange(t) 


melody_graph <- melody_graphable %>%
    arrange(note) %>%
    as_tbl_graph()

melody_graph

write_rds(melody_graph, 'outputs/step-output/melody_graph.rds')
