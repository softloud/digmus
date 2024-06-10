list.files('step-by-step', full.names = TRUE) |>
    purrr::map(source)

system('rm outputs/step-output/*')

source('step-by-step/1-convert-midi-to-R-object.R')
pyramidi_notes

source('step-by-step/2-pyramidi-to-df.R')
melody_df

source('step-by-step/3-melody-tab.R')

source('step-by-step/4-melody-graph.R')
melody_graphable

melody_graph

source('step-by-step/5-melody-img.R')
melody_graph_plot

source('step-by-step/6-melody-animate.R')
melody_animation

source('step-by-step/7-add-audio.R')