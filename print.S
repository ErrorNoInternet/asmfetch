.lcomm print_buf, 1024

print:
	mov bl, [rsi]
	inc rsi

	mov [print_buf + r10], bl
	inc r10

	dec rcx
	jnz print

	ret

println:
	mov bl, [rsi]
	inc rsi

	mov [print_buf + r10], bl
	inc r10

	dec rcx
	jnz println

	mov byte ptr [print_buf + r10], '\n'
	inc r10

	ret

printc:
	mov [print_buf + r10], bl
	inc r10
	ret

flush:
	mov rax, SYS_WRITE
	mov rdi, 1
	mov rsi, offset print_buf
	mov rdx, r10
	syscall

	xor r10, r10
	ret
