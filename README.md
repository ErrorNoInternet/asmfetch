# asmfetch

A fetch tool written in x86-64 assembly. Runs in under 250 microseconds.

There is almost no error handling, and lots of things may break.
Please report any bugs you find.

![Preview](/asmfetch.png)

## Usage

```
$ gcc -nostdlib -no-pie asmfetch.S -o asmfetch
$ ./asmfetch
```

## Customization

It wasn't designed to be very customizable, but you can tweak one or two things
(including the logo) by modifying the includes in `asmfetch.S`.
