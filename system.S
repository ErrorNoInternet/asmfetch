system_label: .ascii "System    "

print_system:
	mov  rsi, offset system_symbol
	mov  rcx, 6
	call print

	mov  rsi, offset accent1
	mov  rcx, 5
	call print

	mov  rsi, offset system_label
	mov  rcx, 10
	call print

	mov  rsi, offset separator_symbol
	mov  rcx, 8
	call print

	mov  rcx, pretty_name_length
	test rcx, rcx
	je   print_unknown_system

	mov rsi, offset pretty_name + 2
	sub rcx, 3
	jmp print_known_system

print_unknown_system:
	mov rsi, offset unknown_label
	mov rcx, 7

print_known_system:
	call println

	ret
