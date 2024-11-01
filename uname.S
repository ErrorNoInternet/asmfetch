.lcomm sysname, UTSNAME_SIZE
.lcomm sysname_length, 8

.lcomm hostname, UTSNAME_SIZE
.lcomm hostname_length, 8

.lcomm release, UTSNAME_SIZE
.lcomm release_length, 8

.lcomm machine, UTSNAME_SIZE
.lcomm machine_length, 8

.lcomm utsname, UTSNAME_SIZE * 6

uname:
	mov rax, SYS_UNAME
	mov rdi, offset utsname
	syscall

	mov  rsi, offset utsname
	mov  rdi, offset sysname
	call copy
	mov  sysname_length, rcx

	mov  rsi, offset utsname + UTSNAME_SIZE
	mov  rdi, offset hostname
	call copy
	mov  hostname_length, rcx

	mov  rsi, offset utsname + UTSNAME_SIZE * 2
	mov  rdi, offset release
	call copy
	mov  release_length, rcx

	mov  rsi, offset utsname + UTSNAME_SIZE * 4
	mov  rdi, offset machine
	call copy
	mov  machine_length, rcx

	ret
