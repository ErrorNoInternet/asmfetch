# asmfetch

A fetch tool written in x86-64 assembly for Linux.
Runs in under 150 microseconds and has zero dependencies.

![Preview](/asmfetch.png)

## Detections

- username (`$USER`)
- hostname
- os name from `/etc/os-release`
- kernel
  - name
  - version
  - architecture
- shell (`$SHELL`)
- uptime
- desktop (`$XDG_CURRENT_DESKTOP`)
- display backend (`$XDG_SESSION_TYPE`)
- memory usage
- disk usage for `/`

## Usage

```sh
make # replaces fedora logo with your distro's and compiles
make install # copies asmfetch to /usr/local/bin
asmfetch
```

## Customization

asmfetch wasn't designed to be very customizable or dynamic; tons of
values (e.g. the logo, symbols, format, colors) are hardcoded. The
only way to change them is by modifying the source code, specifically
the `include`ed files in `asmfetch.S` and symbols in `symbols.S`.
