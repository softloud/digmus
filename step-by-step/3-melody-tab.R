library(gt)

graph_dat <- readRDS('data-raw/step-output/melody_df.rds')


# this table helps make sense of the graph object
melody_tab <- graph_dat %>% gt() %>% tab_header(
        md('![](https://upload.wikimedia.org/score/k/u/kuqreev9vn17n29y7rcsbjjw752x7we/kuqreev9.png)')) 

melody_tab

gtsave(melody_tab, 'img/melody-table.png')
