export curr_dir := $(shell pwd)
default: install

all: install

clean: uninstall

install:
	bash $(curr_dir)/install.sh

uninstall:
	bash $(curr_dir)/uninstall.sh