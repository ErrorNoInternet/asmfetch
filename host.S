print_host:
	mov  rsi, offset yellow
	mov  rcx, 5
	call print

	mov  rsi, offset username
	mov  rcx, username_length
	call print

	mov  rsi, offset red
	mov  rcx, 5
	call print

	mov  bl, 64
	call printc

	mov  rsi, offset green
	mov  rcx, 5
	call print

	mov  rsi, offset hostname
	mov  rcx, hostname_length
	call println

	ret
