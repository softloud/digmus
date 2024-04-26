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
