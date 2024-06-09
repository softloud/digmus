library(magrittr)

# select relevant columns
pyramidi_raw <- readRDS('data-raw/step-output/pyramidi_subject.rds') 

# create labels
d_minor_text <- c('C#', 'D', 'E', 'F', 'G', 'A', 'Bb')

# will leave engineering labelling for another day
# for now, hardcoding the key

d_minor <- tibble::tibble(
    d_minor_text,
    note = c(61, 62, 64, 65, 67, 69, 70)
)

# wrangle long note data into something for graph input
graph_dat <-
    pyramidi_raw %>%
    dplyr::select(note, b, ticks) %>%
    dplyr::mutate(note_index = rep(1:12, each = 2)) %>%
    dplyr::group_by(note, note_index) %>%
    dplyr::reframe(tick = min(ticks)) %>%
    dplyr::ungroup() %>%
    dplyr::arrange(note_index) %>%
    dplyr::left_join(d_minor, by = 'note') %>%
    {. ->> tmp} %>%
    dplyr::mutate(next_note_text = c(.$d_minor_text[2:12], 'D'),
        next_note = c(.$note[2:12], 64)) %>%
    dplyr::select(
        note_index,
        d_minor_text,
        note,
        next_note_text,
        next_note,
        tick
    )
rm(tmp)

graph_dat

saveRDS(graph_dat, 'data-raw/step-output/graph_dat.rds')
