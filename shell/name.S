.include "shell/common.S"

	mov rsi, offset shell_path
	add rsi, shell_path_length
	mov rcx, -1

rstrip:
	inc rcx
	dec rsi
	mov bl, [rsi]
	cmp bl, '/'
	jne rstrip

	inc  rsi
	call println

	ret
