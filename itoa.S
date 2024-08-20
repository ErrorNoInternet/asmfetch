itoa:
	mov rsi, 10

itoa_loop:
	test rax, rax
	jne  itoa_convert

	mov rcx, 10
	sub rcx, rsi
	ret

itoa_convert:
	xor rdx, rdx
	div rbx
	add rdx, '0'
	dec rsi
	mov [rdi + rsi], dl
	jmp itoa_loop
