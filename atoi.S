atoi:
	xor rax, rax

atoi_convert:
	mov dl, [rsi]
	inc rsi

	test rdx, rdx
	je   done

	cmp rdx, '0'
	jl  error

	sub  rdx, '0'
	imul rax, 10
	add  rax, rdx

	jmp atoi_convert

error:
	mov rax, -1

done:
	ret
