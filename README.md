# Wireshark Stream Logger

This is a command-line tool that extracts and logs information belonging to all [UDP, TCP] streams from a given Wireshark pcap file. It utilizes the Tshark tool to process the pcap file and generate separate log files for each TCP stream found.

# Usage
```
Usage: wshark_read_streams [capture.pcap] [udp|tcp] [options] ...
Options:
    -h, --help            Show this help
    -s, --select [list]   Select streams to process
    -o, --output [path]   Output path to store the folder with the stream logs. Default is the current directory

Examples:
    /usr/local/bin/wshark_read_streams capture.pcap tcp
    /usr/local/bin/wshark_read_streams capture.pcap tcp -s "1,2,3"
    /usr/local/bin/wshark_read_streams capture.pcap tcp -s "2"
    /usr/local/bin/wshark_read_streams capture.pcap tcp -o "/home/user/streams"
```

# Installation
1. `git clone git@github.com:marc-gav/Wireshark-log-stream-info.git --depth 1`
2. `cd Wireshark-log-stream-info`
3. `make` or `make install` # This will place a symbolic link of the bash script in `/usr/local/bin`

# Requirements
- `tshark`: `Wireshark` includes `tshark`. Make sure to include it into your `PATH`.
  
# Why?
I was doing a CTF that required doing string manipulation on various UDP streams. I needed an easy way to get all of the information you can obtain by doing `Follow -> UDP stream -> Save as...` without the huge inconveniece of doing it for hundreds of streams. Wireshark offers a CLI frontend named `tshark` that provides the same functionalities but with the terminal's power to automate everything. I found that the following script does exactly what I needed : https://osqa-ask.wireshark.org/questions/24207/invalid-addressport-pair. Inspired by the script I decided to turn it into a tool that anyone can easily install and use.

I am not aware if Wireshark already offers such functionality. Please raise an issue if that is the case.
