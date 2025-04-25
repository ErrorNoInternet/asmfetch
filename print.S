.lcomm print_buf, 1024

print:
	mov bl, [rsi]
	inc rsi

	mov [r10], bl
	inc r10

	dec rcx
	jnz print

	ret

println:
	mov bl, [rsi]
	inc rsi

	mov [r10], bl
	inc r10

	dec rcx
	jnz println

	mov byte ptr [r10], '\n'
	inc r10

	ret
