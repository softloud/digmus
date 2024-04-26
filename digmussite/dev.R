library(tidyverse) # grabbag of datasci tools
library(gt) # for tables
library(ggraph)
library(gganimate)
library(tidygraph)

mdat <- read_csv('mididat.csv')

d_minor <- c('D', 'E', 'F', 'G', 'A', 'Bb', 'C#')

# create ggraph object 
mg_dat <- mdat |>
    mutate(
        to = c(mdat$d_minor[2:12], 'D')
    ) |>
    select(
        from = d_minor, to, timepoint, note
    ) |>
    as_tbl_graph() 

mg_dat

# first look
ggraph(mg_dat, layout = 'linear') +
    geom_edge_fan() + 
    geom_node_point(size = 10) +
    geom_node_text(colour = 'white', aes(name)) +
    theme_graph(
        background = 'white'
    ) +
    transition_time(timepoint)


#ggsave('firsttry.png')

subject_dat <- mididat |>
    left_join(d_minor, by = 'note') |>
    mutate(step = rep.int(c('start', 'stop'), times = 12), 
        index = rep(seq(1, 12), each = 2)) |>
        pivot_wider(names_from = step, values_from = b) |>   
    mutate(
        note = as.integer(note),
        b = start,
        start = as.integer(round(start)),
        stop = as.integer(round(stop)),
        bar = start %/% 16 + 1,
        bar = as.integer(bar),
        duration = stop - start
    ) |>
    select(d_minor, note, start, duration, bar, b) 


gtfirsttry <- 
subject_dat |> gt() |>
    tab_header(md('![](https://upload.wikimedia.org/score/k/u/kuqreev9vn17n29y7rcsbjjw752x7we/kuqreev9.png)'))
