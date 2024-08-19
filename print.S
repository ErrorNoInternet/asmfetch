.lcomm print_buf, 4096

print_logo:
	mov  rcx, LOGO_WIDTH
	call print
	ret

print:
	mov bl, [rsi]
	inc rsi

	mov [print_buf + r10], bl
	inc r10

	dec  rcx
	test rcx, rcx
	jne  print

	ret

println:
	mov bl, [rsi]
	inc rsi

	mov [print_buf + r10], bl
	inc r10

	dec  rcx
	test rcx, rcx
	jne  println

	mov bl, 10
	mov [print_buf + r10], bl
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
