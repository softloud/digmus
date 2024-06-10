# digmus

![](outputs/plots-tabs/melody_graph.jpg)


An experimentation with animating a melody as a graph. 

![](contrapunctus-i.mp4)

## Unsolved problem

Including a self loop on the graph gets the timing right, however, the first edge is dropped. 

![](outputs/plots-tabs/melody-table.png)

## Packages used

```r
# key packages used 
library(pyramidi) # midi wrangling
library(tidygraph) # graph creation
library(ggraph) # graph plotting
library(gganimate) # animation
library(tidyverse) # r tools

# other packages
library(zealot)
library(gt)
library(jpeg)
library(grid)

```

```bash
ffmpeg
timidity

```