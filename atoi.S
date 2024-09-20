atoi:
	xor rax, rax

atoi_convert:
	mov dl, [rsi]
	inc rsi

	test rdx, rdx
	je   atoi_done

	cmp rdx, '0'
	jl  atoi_error

	sub  rdx, '0'
	imul rax, 10
	add  rax, rdx

	jmp atoi_convert

atoi_error:
	mov rax, -1

atoi_done:
	ret
