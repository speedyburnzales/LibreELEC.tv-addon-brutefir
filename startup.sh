#! /bin/sh

# Install BruteFIR config if not existent
if [ ! -f ~/.brutefir_config ]; then
    cp /storage/.kodi/addons/service.system.brutefir/share/brutefir/brutefir_config.example /storage/.brutefir_config
fi
