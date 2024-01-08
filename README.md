# BruteFIR for LibreELEC.tv

This project builds [BruteFIR with PulseAudio support](https://github.com/chipfunk/brutefir) as addon for LibreELEC.tv based distributions.

It supports the following IO modules
- `alsa` for traditional ALSA support
- `pulse` for connecting to a PulseAudio-server
- `file` for file-support


As the patches to BruteFIR are not yet ready for inclusion in the official BruteFIR release, but for general hobby-/amateur-usage, i do NOT use the orignal sources from [Anders Torger's homepage for BruteFIR](http://www.ludd.ltu.se/~torger/brutefir.html) but my own integration-repository.


## Installation

As there is no addon-repository available the addon and its requirements have to be installed via ZIP-file.

Copy resulting zip-file to libreelec-host or some other (USB-)storage-device.

Install addon using the menu `Install from ZIP-file`.


### Prerequisites

[FFTW3](https://fftw.org) has to be available as a shared library. It is provided as two separate addons that have to be installed.

- [fftw3](https://github.com/chipfunk/LibreELEC.tv-addon-fftw3)
- [fftw3f](https://github.com/chipfunk/LibreELEC.tv-addon-fftw3f)


## Setup audio-routing via PulseAudio

Kernel-module `snd-aloop` is missing, so the audio-signal is routed through PulseAudio.

By giving a null-sink the name `BruteFIR` we get a monitoring output named `BruteFIR.monitor` in PulseAudio.
This output will be picked up by BruteFIR's IO-module `pulse`.

The filtered output from BruteFIR is available as a PulseAudio source-output,
which has to be connected to an output for actual sound, e.g. the ALSA-device "default".

Described audio-setup is provided by script `/storage/.kodi/addons/service.system.brutefir/usr/share/brutefir/pulseaudio.sh`, but you can use other mechanisms to do so.


### Configure PulseAudio to provide null-sink to stream to BruteFIR

    # Load null-sink to loopback Kodi-output to BruteFIRs input-stream
    pactl load-module module-null-sink sink_name="BruteFIR"

    # Declare null-sink as default output, will pickup audio from its monitor-out, shown in brutefir_configuration.example-configuration
    pactl set-default-sink BruteFIR


### Activate ALSA soundcard

    # Provide ALSA-card to PulseAudio. The resulting sink will be named `alsa_output.default`.
    pactl load-module module-alsa-sink device=default


### Set KODI to output audio via PulseAudio

Use the menu `Settings/LibreELEC/Audio` to switch KODI output to PulseAudio. Select the newly available device.


## Autostart

To make the changes permanent you can use `kodi-autostart` service to execute autostart-script on system-boot.

The above script is included, copy or append it to `/storage/.config/autostart.sh`.

    echo 'sh /storage/.kodi/addons/service.system.brutefir/usr/share/brutefir/pulseaudio.sh' >> /storage/.config/autostart.sh


## Configuration

BruteFIR loads its configuration from file `/storage/.brutefir_config`. An exmaple is provided in

    /storage/.kodi/addons/service.system.brutefir/usr/share/brutefir/brutefir_config.example

By configuring a PulseAudio `device`-name the sound-server will auto-connect the sink-inputs and source-outputs to the configured and available sinks and sources.

Configure different application-names via param `app_name` if you have multiple instances of BruteFIR connecting to the same PulseAudio-server.


## Build the addon

The addon is build using LibreELEC.tv build-system, so this has to be setup first.

#### Clone LibreELEC.tv

    git clone https://github.com/LibreELEC/LibreELEC.tv
    cd LibreELEC.tv

#### Checkout release

    git checkout 11.0.4


#### Make a directory to hold package and dependencies

In LibreELEC.tv repository create a subfolder for additional packages

    mkdir -p packages/chipfunk
    cd packages/chipfunk/


#### Clone requirements

    git clone https://github.com/chipfunk/LibreELEC.tv-addon-fftw3 fftw3
    git clone https://github.com/chipfunk/LibreELEC.tv-addon-fftw3f fftw3f


#### Clone addon

    git clone https://github.com/chipfunk/LibreELEC.tv-addon-brutefir brutefir


#### Prepare build environment

You can add environment-variables to build for a specific target-device and -platform. Now is a good time to do so.

For a Hardkernel Odroid-C2 i use

    PROJECT=LibreELEC
    PROJECT=Amlogic
    DEVICE=AMLGX
    ARCH=arm


#### Build a release first

As this takes a long time

In LibreELEC.tv repository run

    make release


In the meantime get something to hydrate yourself.


#### Build this addon

In LibreELEC.tv repository run

    scripts/create_addon brutfir


You should end-up with a zip-file in folder

    target/addons/11.0/${PROJECT}/service.system.brutefir/service.system.brutefir-${VERSION}-${ADDON_VERSION}.zip


## Troubleshooting

A short list of helpful commands for pulseaudio

    pactl list sinks
    pactl list sources

    pactl list sink-inputs
    pactl list source-outputs


### Commands systemd



#### Start the service

    systemctl start service.system.brutefir.service


#### Stop the service

    systemctl stop service.system.brutefir.service


#### Restart the service

    systemctl restart service.system.brutefir.service


Happy filtering :)

