shell_label: .ascii "Shell     "

print_shell:
	mov  rsi, offset shell_symbol
	mov  rcx, 5
	call print

	mov  rsi, offset blue
	mov  rcx, 5
	call print

	mov  rsi, offset shell_label
	mov  rcx, 10
	call print

	mov  rsi, offset separator_symbol
	mov  rcx, 8
	call print

	mov rsi, offset shell_path
	add rsi, shell_path_length
	mov rcx, -1

rstrip:
	inc rcx
	dec rsi
	mov bl, [rsi]
	cmp bl, 47
	jne rstrip

	inc  rsi
	call println

	ret
