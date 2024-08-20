desktop_label: .ascii "Desktop      "

print_desktop:
	mov  rsi, offset desktop_symbol
	mov  rcx, 5
	call print

	mov  rsi, offset blue
	mov  rcx, 5
	call print

	mov  rsi, offset desktop_label
	mov  rcx, 13
	call print

	mov  rsi, offset reset
	mov  rcx, 4
	call print

	mov  rsi, offset separator_symbol
	mov  rcx, 4
	call print

	mov  rsi, offset desktop
	mov  rcx, desktop_length
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
