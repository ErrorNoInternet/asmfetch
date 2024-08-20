.include "kernel/common.S"

	mov  rsi, offset release
	mov  rcx, release_length
	call println

	ret
