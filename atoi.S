atoi:
	xor rax, rax

atoi_convert:
	mov   bl, [rsi]
	inc   rsi
	movzx rdi, bl

	test rdi, rdi
	je   done

	cmp rdi, 48
	jl  error
	cmp rdi, 57
	jg  error

	sub  rdi, 48
	imul rax, 10
	add  rax, rdi

	jmp atoi_convert

error:
	mov rax, -1

done:
	ret
