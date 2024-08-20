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

	mov  rsi, offset release
	mov  rcx, release_length
	call println

	# mov  rsi, offset open_paren_label
	# mov  rcx, 2
	# call print
	#
	# mov  rsi, offset machine
	# mov  rcx, machine_length
	# call print
	#
	# mov  rsi, offset close_paren_label
	# mov  rcx, 2
	# call print

	ret
