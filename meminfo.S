meminfo_file: .asciz "/proc/meminfo"

.lcomm memavailable, 8
.lcomm meminfo_buf, 128

parse_meminfo:
	mov rax, SYS_OPEN
	mov rdi, offset meminfo_file
	xor rsi, rsi
	xor rdx, rdx
	syscall

	mov rdi, rax
	mov rax, SYS_READ
	mov rsi, offset meminfo_buf
	mov rdx, 128
	syscall

	cmp rax, 128
	je  meminfo_available

	ret

meminfo_available:
	xor r8, r8
	mov r9, offset number_buf

skip_line:
	mov bl, [rsi]
	inc rsi

	cmp bl, '\n'
	jne skip_line

	inc r8
	cmp r8, 2
	jne skip_line

	add rsi, 13

skip_space:
	mov bl, [rsi]
	inc rsi

	cmp bl, ' '
	je  skip_space

parse_memavailable:
	mov [r9], bl
	inc r9

	mov bl, [rsi]
	inc rsi

	cmp bl, ' '
	je  meminfo_done

	jmp parse_memavailable

meminfo_done:
	mov  rsi, offset number_buf
	call atoi
	mov  memavailable, rax

	ret
