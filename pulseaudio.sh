#! /bin/sh

# Load null-sink to loopback Kodi-output to BruteFIRs input-stream
pactl load-module module-null-sink sink_name="BruteFIR"

# Declare null-sink as default output, will pickup audio from its monitor-out
pactl set-default-sink BruteFIR

# Provide ALSA output
pactl load-module module-alsa-sink sink_name="alsa_output.default"
