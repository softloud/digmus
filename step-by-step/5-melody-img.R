library(ggraph)

# img for background pkgs
library(jpeg)
library(grid)

# set image for background #

# image from https://www.vecteezy.com/vector-art/112278-textured-grunge-background

# Load the image
img <- readJPEG("img/parchment.jpg")

# Create a raster object from the image
background_raster <- rasterGrob(img, interpolate=TRUE)

# set colours

dark_sepia <- '#704214'
light_sepia <- '#C0A080'
lightest_sepia <- '#F5DEB3'

# get melody as graph R object
melody_graph <- read_rds('data-raw/step-output/melody_graph.rds')


# how to make the background image always the same size as plot in preview?
melody_graph_plot <- 
    melody_graph |>
        ggraph(layout = 'linear') +
        annotation_custom(background_raster, xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf) +
        geom_edge_arc(
            aes(group = note), show.legend = FALSE, 
            colour = dark_sepia, alpha = 0.8) + 
        geom_node_point(size = 20, colour = dark_sepia) +
        geom_node_text(
            size = 10,
            aes(label = name),
            colour = lightest_sepia) +
        theme_graph(background = 'transparent') +  # Make the background transparent to show the image
        theme(plot.margin = margin(0, 0, 0, 0))   # Remove margins

write_rds(melody_graph_plot, 'data-raw/step-output/melody_graph_plot.rds')

# Save the plot to see - previewing makes the background weird
# but the background image still isn't quite sitting how it should
ggsave("img/melody_graph.jpg", 
    melody_graph_plot, 
    width = 1330 * 3, 
    height = 881 * 3, units = 'px')
