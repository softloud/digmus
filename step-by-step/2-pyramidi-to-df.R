library(magrittr)

# select relevant columns
pyramidi_raw <- readRDS('outputs/step-output/pyramidi_notes.rds') 

melody_df <- 
  pyramidi_raw %>% 
    dplyr::mutate(
      status = dplyr::if_else(time == 0, 'on', 'off'),
      ii_note = (i_note + 1) %/% 2,
      note_name = stringr::str_remove(note_name, '\\d+')
    ) %>% dplyr::select(ii_note, note, note_name, t, status) %>%
    tidyr::pivot_wider(names_from = status, values_from = t) 

saveRDS(melody_df, 'outputs/step-output/melody_df.rds')
