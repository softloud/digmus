# digmus

![](outputs/plots-tabs/melody_graph.jpg)


An experimentation with animating a melody as a graph. 

<iframe width="560" height="315" src="https://www.youtube.com/embed/hmPNfeZ7w9k?si=a9KK5kMGkj4aZzIE" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

![](outputs/plots-tabs/melody-table.png)


## Unsolved problem

Including a self loop on the graph gets the timing right, however, the first edge is dropped. 

![](outputs/plots-tabs/melody-graphable.png)

## Packages used

### r

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

### bash

```bash
ffmpeg
timidity

```

## Midi

[Raw midi file](https://github.com/softloud/digmus/tree/main/midi) sourced from wikipedia's page on [The Art of Fugue](https://en.wikipedia.org/wiki/The_Art_of_Fugue). 

![](https://upload.wikimedia.org/wikipedia/commons/0/06/Title_page_of_The_Art_of_Fugue.jpg)


## Code

See [step-by-step](https://github.com/softloud/digmus/tree/main/step-by-step) for each step of the process, from wranging midi, to plotting a graph, to animation. 

## Outputs 

Written to outputs/, but not all files are there as some of the intermediary files are too large to push to Git. 