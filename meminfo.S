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
	mov r13, offset number_buf
	xor r8, r8
	xor r9, r9

skip_line:
	mov bl, [meminfo_buf + r8]
	inc r8

	cmp bl, '\n'
	jne skip_line

	inc r9
	cmp r9, 2
	jne skip_line

	add r8, 13

skip_space:
	mov bl, [meminfo_buf + r8]
	inc r8

	cmp bl, ' '
	je  skip_space

parse_memavailable:
	mov [r13], bl
	inc r13

	mov bl, [meminfo_buf + r8]
	inc r8

	cmp bl, ' '
	je  meminfo_done

	jmp parse_memavailable

meminfo_done:
	mov  rsi, offset number_buf
	call atoi
	mov  memavailable, rax

	ret
