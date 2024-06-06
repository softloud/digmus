library(gt)

graph_dat <- readRDS('data-raw/graph_dat.rds')


# this table helps make sense of the graph object
graph_dat %>% gt() %>% tab_header(
        md('![](https://upload.wikimedia.org/score/k/u/kuqreev9vn17n29y7rcsbjjw752x7we/kuqreev9.png)')) 
