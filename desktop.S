desktop_label: .ascii "Desktop   "
unknown_desktop_label: .ascii "Unknown"

print_desktop:
	mov  rsi, offset desktop_symbol
	mov  rcx, 5
	call print

	mov  rsi, offset blue
	mov  rcx, 5
	call print

	mov  rsi, offset desktop_label
	mov  rcx, 10
	call print

	mov  rsi, offset separator_symbol
	mov  rcx, 8
	call print

	mov  bl, [desktop]
	test bl, bl
	je   print_unknown_desktop

	mov rsi, offset desktop
	mov rcx, desktop_length
	jmp print_known_desktop

print_unknown_desktop:
	mov rsi, offset unknown_desktop_label
	mov rcx, 7

print_known_desktop:
	call print

	mov  rsi, offset open_paren_label
	mov  rcx, 2
	call print

	mov  bl, [session]
	sub  bl, 32
	mov  [session], bl
	mov  rsi, offset session
	mov  rcx, session_length
	call print

	mov  rsi, offset close_paren_label
	mov  rcx, 2
	call print

	ret
