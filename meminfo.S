meminfo_file: .asciz "/proc/meminfo"

.lcomm memtotal, 8
.lcomm memavailable, 8

.lcomm memtotal_buf, 10
.lcomm memavailable_buf, 10
.lcomm meminfo_buf, 128

populate_meminfo:
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

	xor r8, r8
	xor r9, r9
	xor r10, r10

meminfo_total:
	mov bl, [meminfo_buf + r8]
	inc r8

	cmp bl, 58
	jne meminfo_total

meminfo_total_skip_space:
	mov bl, [meminfo_buf + r8]
	inc r8

	cmp bl, 32
	je  meminfo_total_skip_space

meminfo_total_parse:
	mov [memtotal_buf + r10], bl
	inc r10

	mov bl, [meminfo_buf + r8]
	inc r8

	cmp bl, 32
	je  meminfo_total_done

	jmp meminfo_total_parse

meminfo_total_done:
	mov  rsi, offset memtotal_buf
	call atoi
	mov  memtotal, rax

	xor r9, r9
	xor r10, r10

meminfo_available:
	mov bl, [meminfo_buf + r8]
	inc r8
	cmp bl, 10
	jne meminfo_available

	inc r9
	cmp r9, 2
	jne meminfo_available

meminfo_available_skip_colon:
	mov bl, [meminfo_buf + r8]
	inc r8

	cmp bl, 58
	jne meminfo_available_skip_colon

meminfo_available_skip_space:
	mov bl, [meminfo_buf + r8]
	inc r8

	cmp bl, 32
	je  meminfo_available_skip_space

meminfo_available_parse:
	mov [memavailable_buf + r10], bl
	inc r10

	mov bl, [meminfo_buf + r8]
	inc r8

	cmp bl, 32
	je  meminfo_done

	jmp meminfo_available_parse

meminfo_done:
	mov  rsi, offset memavailable_buf
	call atoi
	mov  memavailable, rax

	ret
