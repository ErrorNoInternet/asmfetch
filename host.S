unknown_user_label: .ascii "nobody"

print_host:
	mov  rsi, offset yellow
	mov  rcx, 5
	call print

	mov  rcx, username_length
	test rcx, rcx
	je   print_unknown_user

	mov rsi, offset username
	jmp print_known_user

print_unknown_user:
	mov rsi, offset unknown_user_label
	mov rcx, 6

print_known_user:
	call print

	mov  rsi, offset red
	mov  rcx, 5
	call print

	mov  bl, '@'
	call printc

	mov  rsi, offset green
	mov  rcx, 5
	call print

	mov  rsi, offset hostname
	mov  rcx, hostname_length
	call println

	ret
