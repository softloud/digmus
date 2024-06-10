library(magrittr)

# select relevant columns
pyramidi_raw <- readRDS('data-raw/step-output/pyramidi_subject.rds') 

melody_df <- 
  pyramidi_raw %>% 
    dplyr::mutate(
      status = dplyr::if_else(time == 0, 'on', 'off'),
      ii_note = (i_note + 1) %/% 2,
      note_name = stringr::str_remove(note_name, '4')
    ) %>% dplyr::select(ii_note, note, note_name, t, status) %>%
    tidyr::pivot_wider(names_from = status, values_from = t) 

saveRDS(melody_df, 'data-raw/step-output/melody_df.rds')
