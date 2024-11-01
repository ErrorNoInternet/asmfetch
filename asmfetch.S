.intel_syntax noprefix

.lcomm number_buf, 10

.include "atoi.S"
.include "constants.S"
.include "copy.S"
.include "itoa.S"
.include "print.S"
.include "symbols.S"

.include "env.S"
.include "meminfo.S"
.include "release.S"
.include "sysinfo.S"
.include "uname.S"

.include "circles.S"
.include "desktop.S"
.include "host.S"
.include "memory.S"
.include "storage.S"
.include "system.S"
.include "uptime.S"

# customization
.include "colors/default.S"
.include "kernel/without_machine.S"
.include "logo/fedora.S"
.include "shell/path.S"

.global _start

_start:
	mov  rbp, rsp
	add  rbp, 24
	call parse_envs
	call parse_release
	call sysinfo
	call uname
	call parse_meminfo

	mov  rsi, offset LOGO_0
	mov  rcx, LOGO_1 - LOGO_0
	call print
	call print_host

	mov  rsi, offset LOGO_1
	mov  rcx, LOGO_2 - LOGO_1
	call print
	call print_system

	mov  rsi, offset LOGO_2
	mov  rcx, LOGO_3 - LOGO_2
	call print
	call print_kernel

	mov  rsi, offset LOGO_3
	mov  rcx, LOGO_4 - LOGO_3
	call print
	call print_shell

	mov  rsi, offset LOGO_4
	mov  rcx, LOGO_5 - LOGO_4
	call print
	call print_uptime

	mov  rsi, offset LOGO_5
	mov  rcx, LOGO_6 - LOGO_5
	call print
	call print_desktop

	mov  rsi, offset LOGO_6
	mov  rcx, LOGO_7 - LOGO_6
	call print
	call print_memory

	mov  rsi, offset LOGO_7
	mov  rcx, LOGO_8 - LOGO_7
	call print
	call print_storage

	mov  rsi, offset LOGO_8
	mov  rcx, LOGO_END - LOGO_8
	call print
	call print_colors

	mov  rsi, offset reset
	mov  rcx, 4
	call print
	call flush

	mov rax, SYS_EXIT
	xor rdi, rdi
	syscall
