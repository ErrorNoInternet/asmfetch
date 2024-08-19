os_release_file: .asciz "/etc/os-release"
var_pretty_name: .ascii "PRETTY_NAME"

.lcomm pretty_name, 65
.lcomm pretty_name_length, 8

.lcomm os_release_buf, 1024

populate_release:
	mov rax, SYS_OPEN
	mov rdi, offset os_release_file
	xor rsi, rsi
	xor rdx, rdx
	syscall

	mov rdi, rax
	mov rax, SYS_READ
	mov rsi, offset os_release_buf
	mov rdx, 1023
	syscall

	mov  rax, offset os_release_buf
	xor  r8, r8
	xor  r9, r9
	xor  r13, r13
	xor  rsi, rsi
	call var_loop
	ret

var_loop:
	mov r14, r8
	add r14, r9
	mov bl, [rax + r14]

	cmp bl, [var_pretty_name + r9]
	je  var_char_matched

	xor rsi, rsi

	cmp bl, 10
	je  var_check_zero

skip_var:
	xor r13, r13
	inc r9

	mov r14, r8
	add r14, r9
	mov bl, [rax + r14]

	cmp bl, 10
	jne skip_var

	inc r13
    inc r8
	add r8, r9
	xor r9, r9
	jmp var_loop

var_char_matched:
	inc r9

	inc rsi
	cmp rsi, 11
	jne var_loop

	mov r14, r8
	add r14, r9
	add r14, rax
	inc r14

	mov  rsi, r14
	mov  rdi, offset pretty_name
	call copy_eol
	mov  pretty_name_length, rcx
	ret

var_check_zero:
	cmp r13, 1
	jne skip_var
	ret
