desktop_label: .ascii "Desktop   "

print_desktop:
	mov  rsi, offset desktop_symbol
	mov  rcx, 5
	call print

	mov  rsi, offset accent1
	mov  rcx, 5
	call print

	mov  rsi, offset desktop_label
	mov  rcx, 10
	call print

	mov  rsi, offset separator_symbol
	mov  rcx, 8
	call print

	mov  rcx, desktop_length
	test rcx, rcx
	je   print_unknown_desktop

	mov rsi, offset desktop
	jmp print_known_desktop

print_unknown_desktop:
	mov rsi, offset unknown_label
	mov rcx, 7

print_known_desktop:
	call print

	mov  rax, session_length
	test rax, rax
	jne  check_session

	mov byte ptr [r10], '\n'
	inc r10

	ret

check_session:
	mov  rsi, offset open_paren_label
	mov  rcx, 2
	call print

	mov ebx, [session]
	cmp ebx, 0x797474
	je  upper

	sub bl, 0x20
	jmp print_session

upper:
	sub ebx, 0x202020

print_session:
	mov  [session], ebx
	mov  rsi, offset session
	mov  rcx, session_length
	call print

	mov  rsi, offset close_paren_label
	mov  rcx, 2
	call print

	ret
