.intel_syntax noprefix

.include "atoi.S"
.include "constants.S"
.include "copy.S"
.include "escapes.S"
.include "itoa.S"
.include "logo.S"
.include "print.S"
.include "symbols.S"

.include "env.S"
.include "meminfo.S"
.include "release.S"
.include "statfs.S"
.include "sysinfo.S"
.include "uname.S"

.include "colors.S"
.include "desktop.S"
.include "host.S"
.include "kernel.S"
.include "memory.S"
.include "shell.S"
.include "storage.S"
.include "system.S"
.include "uptime.S"

.global _start

_start:
	mov  r15, [rsp + 32]
	call populate_envs
	call populate_release
	call populate_sysinfo
	call populate_utsname
	call populate_meminfo
	call populate_statfs

	mov  rsi, offset LOGO_0
	call print_logo
	call print_host

	mov  rsi, offset LOGO_1
	call print_logo
	call print_system

	mov  rsi, offset LOGO_2
	call print_logo
	call print_kernel

	mov  rsi, offset LOGO_3
	call print_logo
	call print_shell

	mov  rsi, offset LOGO_4
	call print_logo
	call print_uptime

	mov  rsi, offset LOGO_5
	call print_logo
	call print_desktop

	mov  rsi, offset LOGO_6
	call print_logo
	call print_memory

	mov  rsi, offset LOGO_7
	call print_logo
	call print_storage

	mov  rsi, offset LOGO_8
	call print_logo
	call print_colors

	mov  rsi, offset reset
	mov  rcx, 4
	call print
	call flush

	mov rax, SYS_EXIT
	xor rdi, rdi
	syscall
