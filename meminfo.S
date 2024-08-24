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
	mov rdx, 127
	syscall

	cmp rax, 127
	je  meminfo_available

	ret

meminfo_available:
	xor r8, r8
	xor r9, r9
	xor r11, r11

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
	mov [number_buf + r11], bl
	inc r11

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
