.include "shell/common.S"

	mov  rsi, offset shell_path
	mov  rcx, shell_path_length
	call println

	ret
