.lcomm number_buf, 10

itoa:
	mov rsi, 10

itoa_convert:
	xor  rdx, rdx
	div  rbx
	add  rdx, '0'
	dec  rsi
	mov  [rdi + rsi], dl
	test rax, rax
	jne  itoa_convert

itoa_done:
	mov rcx, 10
	sub rcx, rsi
	ret
