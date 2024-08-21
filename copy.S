copy_null:
	xor rcx, rcx

copy_null_loop:
	mov bl, [rsi + rcx]

	test bl, bl
	je   copy_null_done

	mov [rdi + rcx], bl
	inc rcx

	jmp copy_null_loop

copy_null_done:
	ret

copy_eol:
	xor rcx, rcx

copy_eol_loop:
	mov bl, [rsi + rcx]

	cmp bl, '\n'
	je  copy_eol_done

	mov [rdi + rcx], bl
	inc rcx

	jmp copy_eol_loop

copy_eol_done:
	ret
