# Wireshark Stream Logger

This is a command-line tool that extracts and logs information belonging to all [UDP, TCP] streams from a given Wireshark pcap file. It utilizes the Tshark tool to process the pcap file and generate separate log files for each TCP stream found.

# Why?
I was doing a CTF that required doing string manipulation on various UDP streams and I needed an easy way to get all of the information that you can obtain by doing `Follow -> UDP stream -> Save as...` automatically for any number of streams. I found the following script that inspired this repo: https://osqa-ask.wireshark.org/questions/24207/invalid-addressport-pair.

I am not aware if Wireshark already offers such functionality. Please raise an issue if that is the case. I would be more than happy to turn this into a PR for Wireshark.
