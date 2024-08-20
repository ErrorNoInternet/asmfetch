kernel_label: .ascii "Kernel    "

print_kernel:
	mov  rsi, offset kernel_symbol
	mov  rcx, 5
	call print

	mov  rsi, offset blue
	mov  rcx, 5
	call print

	mov  rsi, offset kernel_label
	mov  rcx, 10
	call print

	mov  rsi, offset reset
	mov  rcx, 4
	call print

	mov  rsi, offset separator_symbol
	mov  rcx, 4
	call print

	mov  rsi, offset sysname
	mov  rcx, sysname_length
	call print

	mov  bl, 32
	call printc
