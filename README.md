# asmfetch

A fetch tool written in x86-64 assembly for Linux.
Runs in under 150 microseconds and has zero dependencies.

There is almost no error handling and lots of things may break.
Please report any bugs you find.

![Preview](/asmfetch.png)

## Usage

```shell
$ gcc -nostdlib -no-pie asmfetch.S -o asmfetch
$ ./asmfetch
```

## Customization

It wasn't designed to be very customizable or dynamic; tons of values
are hardcoded, but you can tweak one or two things (including the logo)
by modifying the includes in `asmfetch.S` and symbols in `symbols.S`.
