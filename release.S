os_release_file: .asciz "/etc/os-release"
var_pretty_name: .ascii "PRETTY_NAME"

.lcomm pretty_name, 65
.lcomm pretty_name_length, 8

.lcomm os_release_buf, 512

parse_release:
	mov rax, SYS_OPEN
	mov rdi, offset os_release_file
	xor rsi, rsi
	xor rdx, rdx
	syscall

	mov rdi, rax
	mov rax, SYS_READ
	mov rsi, offset os_release_buf
	mov rdx, 511
	syscall

	mov rax, offset os_release_buf
	xor r8, r8

var_match_loop:
	mov bl, [rax]
	inc rax

	test bl, bl
	je   parse_release_done

	cmp bl, [var_pretty_name + r8]
	je  var_char_matched
	xor r8, r8

	jmp var_match_loop

var_char_matched:
	inc r8
	cmp r8, 11
	jne var_match_loop

	mov  rsi, rax
	mov  rdi, offset pretty_name
	call copy_eol
	mov  pretty_name_length, rcx

parse_release_done:
	ret
