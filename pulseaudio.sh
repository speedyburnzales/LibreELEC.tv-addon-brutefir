#! /bin/sh

# Output to brutefir via FIFO
pactl load-module module-pipe-sink \
    file=/run/pulse/fifo_output \
    sink_name=brutefir_sink \
    format=s16le \
    rate=44100 \
    channels=2

pactl set-default-sink \
    brutefir_sink

# Input from brutefir via FIFO
pactl load-module module-pipe-source \
    file=/run/pulse/fifo_input \
    source_name=brutefir_source \
    format=s16le \
    rate=44100 \
    channels=2

pactl set-default-source \
    brutefir_source

# Load ALSA card for actual sound-ouptput
pactl load-module module-alsa-sink \
    device=default \
    format=s16le \
    rate=44100 \
    channels=2

# Route BruteFIR-output to ALSA card
pactl load-module module-loopback \
    source=brutefir_source \
    source_dont_move=true \
    sink=alsa_output.default \
    sink_dont_move=true \
    format=s16le \
    rate=44100 \
    channels=2
