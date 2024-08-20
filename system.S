system_label: .ascii "System    "

print_system:
	mov  rsi, offset system_symbol
	mov  rcx, 6
	call print

	mov  rsi, offset blue
	mov  rcx, 5
	call print

	mov  rsi, offset system_label
	mov  rcx, 10
	call print

	mov  rsi, offset reset
	mov  rcx, 4
	call print

	mov  rsi, offset separator_symbol
	mov  rcx, 4
	call print

	mov  rsi, offset pretty_name + 1
	mov  rcx, pretty_name_length
	sub  rcx, 2
	call println

	ret
