#!/bin/bash

install_path="/usr/local/bin"

chmod +x wshark_read_streams.sh
ln -s "$(pwd)/wshark_read_streams.sh" "$install_path/wshark_read_streams"
