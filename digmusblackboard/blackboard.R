# image from https://www.vecteezy.com/vector-art/112278-textured-grunge-background

dark_sepia <- '#704214'
light_sepia <- '#C0A080'
lightest_sepia <- '#F5DEB3'

# add a new row at the beginning
start_row <- tibble(
    from = "D",
    to = "D",
    tick = 0, 
    note_index = 0, 
    note = 62 
)

melody_df <- graphdat %>%
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
tidygraph_obj <- melody_df %>%
    arrange(note) %>%
    as_tbl_graph()


# Load the required libraries
library(jpeg)
library(grid)

# Load the image
img <- readJPEG("parchment.jpg")

# Create a raster object from the image
background_raster <- rasterGrob(img, interpolate=TRUE)

# graph plot - ggraph
ggraph_obj <- 
    tidygraph_obj |>
        ggraph(layout = 'linear') +
        annotation_custom(background_raster, xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf) +
        geom_edge_arc(
            aes(group = note_index), show.legend = FALSE, 
            colour = dark_sepia, alpha = 0.8) + 
        geom_node_point(size = 20, colour = dark_sepia) +
        geom_node_text(
            size = 10,
            aes(label = name),
            colour = lightest_sepia) +
        theme_graph(background = 'transparent') +  # Make the background transparent to show the image
        theme(plot.margin = margin(0, 0, 0, 0))   # Remove margins

# Save the plot
ggsave("output_plot.jpg", ggraph_obj, width = 1330 * 3, height = 881 * 3, units = 'px')


# use gganimate on ggraph object 
graph_animation <- ggraph_obj +
    transition_time(tick) +
    shadow_mark()


# Load the required library
library(av)



# Animate and save the animation as a video
animate(graph_animation
     width = 1330, height = 882, 
     duration = 6528,
     renderer = av_renderer("output_animation.mp4"))

# Combine the video and audio files
av_encode_video("output_animation.mp4", audio = "midi/wiki-subject-vlc-convert.mp3", output = "final_output.mp4")


# Load the required library
library(av)
# Define the command as a string
command <- "ffmpeg -i output_animation.mp4 -i midi/wiki-subject-vlc-convert.mp3 -c:v copy -c:a aac -shortest final_output.mp4"

# Run the command
system(command)
# Combine the audio and video files
