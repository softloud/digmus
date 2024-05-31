#!/bin/bash

# Install the necessary tools
# brew install timidity lame

# Download a soundfont (you only need to do this once)
# curl -L -o FluidR3_GM.sf2 'https://github.com/musescore/MuseScore/raw/2.3.2/share/sound/FluidR3Mono_GM.sf2'

# Convert the MIDI file to WAV
# Convert the MIDI file to WAV
# timidity midi/wikisource-contrapunctus-subject.midi -Ow -o output.wav
fluidsynth -ni FluidR3_GM.sf2 your_midi_file.midi -F output.wav


# Convert the WAV file to MP3
lame output.wav output.mp3