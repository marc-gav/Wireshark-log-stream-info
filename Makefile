default: install

install:
	@chmod +x ./wshark_read_streams.sh
	@ln -s ./wshark_read_streams.sh /usr/local/bin/wshark_read_streams
	@printf "Installed wshark_read_streams to /usr/local/bin\n"

uninstall:
	@rm /usr/local/bin/wshark_read_streams
	@printf "Removed wshark_read_streams from /usr/local/bin\n"