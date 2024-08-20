.include "kernel/common.S"

	mov  rsi, offset release
	mov  rcx, release_length
	call print

	mov  rsi, offset open_paren_label
	mov  rcx, 2
	call print

	mov  rsi, offset machine
	mov  rcx, machine_length
	call print

	mov  rsi, offset close_paren_label
	mov  rcx, 2
	call print

	ret
