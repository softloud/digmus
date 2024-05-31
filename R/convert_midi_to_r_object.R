#' Convert MIDI file to R object
#'
#' This function reads a MIDI file and converts it to an R object using the `MidiFramer` class from the `pyramidi` package.
#'
#' @param midi_file A string representing the location of the MIDI file. Defaults to 'data-raw/midi/wikisource-contrapunctus-subject.midi'.
#' @return A `MidiFramer` object representing the MIDI data.
#' @references The default MIDI file is from <https://en.wikipedia.org/wiki/The_Art_of_Fugue>.
#' @export
#' @section Development:
#' The `tuneR` package should be explored for extracting MIDI data as we are currently only using `pyramidi` for this step.
#' @section More MIDI: A source for more MIDI files can be found [here](https://www.bachcentral.com/midiindexcomplete.html).


convert_midi_to_r_object <- function(midi_file = 'data-raw/midi/wikisource-contrapunctus-subject.midi') {
  pyramidi::MidiFramer$new(midi_file)

}