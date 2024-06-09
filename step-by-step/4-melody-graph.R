library(tidyverse) # grabbag of datasci tools
library(gt) # for tables
library(tidygraph) # for graph objects in R
library(ggraph) # for plotting graphs

# get the data #
graph_dat <- readRDS('data-raw/step-output/graph_dat.rds')


# add a new row at the beginning
start_row <- tibble(
    from = "D",
    to = "D",
    tick = 0, 
    note_index = 0, 
    note = 62 
)

melody_df <- graph_dat %>%
    select(
        from = d_minor_text, 
        to = next_note_text, 
        tick, 
        note_index,
        note) |>
    bind_rows(start_row) %>%
    arrange(note_index)


#  hack to be fixed later
melody_df$tick <- c(melody_df$tick[2:13], 7000)

# graph object - tidygraph
melody_graph <- melody_df %>%
    arrange(note) %>%
    as_tbl_graph()

melody_graph

write_rds(melody_graph, 'data-raw/step-output/melody_graph.rds')
