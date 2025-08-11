DISTRO_ID := $(shell sed -n '/^ID=/ s/ID=//p' /etc/os-release)

all: compile_with_distro_logo

compile_with_distro_logo:
	sed -E 's|(\.include "logo/).*(\.S")|\1'"${DISTRO_ID}"'\2|' asmfetch.S |\
	gcc -nostdlib -no-pie -x assembler - -o asmfetch

install:
	#TODO make this work on systems without sudo
	sudo cp asmfetch /usr/local/bin/asmfetch


.PHONY: compile_with_distro_logo install
