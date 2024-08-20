shell_label: .ascii "Shell        "

print_shell:
	mov  rsi, offset shell_symbol
	mov  rcx, 5
	call print

	mov  rsi, offset blue
	mov  rcx, 5
	call print

	mov  rsi, offset shell_label
	mov  rcx, 13
	call print

	mov  rsi, offset reset
	mov  rcx, 4
	call print

	mov  rsi, offset separator_symbol
	mov  rcx, 4
	call print

	mov  rsi, offset shell_path
	mov  rcx, shell_path_length
	call println

	ret
