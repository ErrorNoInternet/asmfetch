copy:
	xor rcx, rcx

copy_loop:
	mov bl, [rsi + rcx]

	cmp bl, r15b
	je  copy_done

	mov [rdi + rcx], bl
	inc rcx

	jmp copy_loop

copy_done:
	ret
