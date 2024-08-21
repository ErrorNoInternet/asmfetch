.include "shell/common.S"

	mov  rcx, shell_path_length
	test rcx, rcx
	je   print_unknown_shell

	mov rsi, offset shell_path
	add rsi, shell_path_length
	mov rcx, -1

rstrip:
	inc rcx
	dec rsi
	mov bl, [rsi]
	cmp bl, '/'
	jne rstrip
	inc rsi
	jmp print_known_shell

print_unknown_shell:
	mov rsi, offset unknown_label
	mov rcx, 7

print_known_shell:
	call println
	ret
