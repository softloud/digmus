list.files('step-by-step', full.names = TRUE) %>%
    lapply(., source)

source('step-by-step/1-convert-midi-to-R-object.R')
source('step-by-step/2-pyramidi-to-df.R')
source('step-by-step/3-melody-tab.R')
source('step-by-step/4-melody-graph.R')
source('step-by-step/5-melody-img.R')
source('step-by-step/6-melody-animate.R')
source('step-by-step/7-add-audio.R')