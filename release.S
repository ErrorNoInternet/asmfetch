os_release_file: .asciz "/etc/os-release"
var_pretty_name: .ascii "PRETTY_NAME"

.lcomm pretty_name, 65
.lcomm pretty_name_length, 8

.lcomm os_release_buf, 513

parse_release:
	mov rax, SYS_OPEN
	mov rdi, offset os_release_file
	xor rsi, rsi
	xor rdx, rdx
	syscall

	mov rdi, rax
	mov rax, SYS_READ
	mov rsi, offset os_release_buf
	mov rdx, 512
	syscall

var_match_loop:
	mov bl, [rsi]
	inc rsi

	test bl, bl
	je   parse_release_done

	cmp bl, [var_pretty_name + r12]
	je  var_char_matched
	xor r12, r12

	jmp var_match_loop

var_char_matched:
	inc r12
	cmp r12, 11
	jne var_match_loop

	mov  rdi, offset pretty_name
	mov  r15, '\n'
	call copy
	mov  pretty_name_length, rcx

parse_release_done:
	ret
