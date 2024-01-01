# BruteFIR for LibreELEC.tv

This project builds [BruteFIR](https://torger.se/anders/brutefir.html) as addon for LibreELEC.tv based distributions.


## Build the addon

The addon is build using LibreELEC.tv build-system, so this has to be seup first.

Clone LibreELEC.tv

    git clone https://github.com/LibreELEC/LibreELEC.tv


Change to package-directory

    cd LibreELEC.tv/packages/audio/


Clone addon-requirements

    git clone https://github.com/chipfunk/LibreELEC.tv-addon-fftw3
    git clone https://github.com/chipfunk/LibreELEC.tv-addon-fftw3f


Clone this addon

    git clone https://github.com/chipfunk/LibreELEC.tv-addon-brutefir


Build addon for your target-device and -platform

    PROJECT=LibreELEC PROJECT=RPi DEVICE=RPi ARCH=arm scripts/create_addon brutfir


You should end-up with a zip-file in folder

    target/addons/${VERSION}/${PROJECT}/service.system.brutefir/service.system.brutefir-${VERSION}-${ADDON_VERSION}.zip


## Installation

As there is no addon-repository available the addon and its requirements have to be installed via ZIP-file.

Copy resulting zip-file to libreelec-host or some other (USB-)storage-device.

Install addon using the menu `Install from ZIP-file`.


## Setup audio-routing via PulseAudio

As kernel-module `snd-aloop` is missing it is required to route the audio-signal through PulseAudio.

Use settings-menu to configure PulseAudio as audio-output for Kodi.

Configure PulseAudio to loopback the filtered audio-signal.

    pactl load-module module-pipe-sink file=/run/pulse/fifo_output sink_name=brutefir_sink
    pactl set-default-sink brutefir_sink


Configure PulseAudio to pick-up filtered signal from FIFO.

    pactl load-module module-pipe-source file=/run/pulse/fifo_input source_name=brutefir_source
    pactl set-default-source brutefir_source


Make ALSA-card available to PulseAudio. The resulting sink will be named `alsa_output`.

    pactl load-module module-alsa-sink device=default


Route BruteFIR-output to ALSA-card.

    pactl load-module module-loopback source=brutefir_source sink=alsa_output.default


To make the changes permanent you can use `kodi-autostart` service to execute autostart-script on system-boot.

The above script is included, copy it to `/storage/.config/autostart.sh`.

    cat /storage/.kodi/addons/service.system.brutefir/usr/share/brutefir/pulseaudio.sh >> /storage/.config/autostart.sh


## Configuration

BruteFIR loads its configuration from file `/storage/.brutefir_config`


## Troubleshooting

A short list of helpful commands for pulseaudio

    pactl list sinks
    pactl list sources

    pactl list sink-inputs
    pactl list source-outputs


Commands systemd

    systemctl list-units
    systemctl is-active service.system.brutefir.service
    systemctl restart service.system.brutefir.service
