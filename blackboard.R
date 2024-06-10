# use gganimate on ggraph object 
melody_graph_plot +
    transition_states(states = t, transition_length = 2, state_length = 1) +
    shadow_mark()

melody_df

# Add a row of NA values at t = 0
melody_graphable <- melody_df %>%
  arrange(on) %>%
  mutate(
    from = note_name,
    to = lead(note_name),
    t = off
  ) %>%
  dplyr::filter(!is.na(to)) %>%
  select(from, to, t, note) %>%
  add_row(from = NA, to = NA, t = 0, note = NA) %>%
  arrange(t)

melody_graph %>%
    ggraph(layout = 'linear') +
    geom_node_point() 