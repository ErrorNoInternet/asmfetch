DISTRO_ID := $(shell sed -n '/^ID=/ s/ID=//p' /etc/os-release)

asmfetch: asmfetch.S
	sed -E 's|(\.include "logo/).*(\.S")|\1'"${DISTRO_ID}"'\2|' asmfetch.S |\
	gcc -nostdlib -no-pie -x assembler - -o $@

install: asmfetch
	install -Dm755 asmfetch /usr/local/bin/


.PHONY: all install
