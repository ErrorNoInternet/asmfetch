env_username:   .ascii "USER"
env_shell:      .ascii "SHELL"
env_desktop:    .ascii "XDG_CURRENT_DESKTOP"
env_session:    .ascii "XDG_SESSION_TYPE"

.lcomm username, 65
.lcomm username_length, 8

.lcomm shell_path, 65
.lcomm shell_path_length, 8

.lcomm desktop, 65
.lcomm desktop_length, 8

.lcomm session, 65
.lcomm session_length, 8

.lcomm target, 65

populate_envs:
	mov  rcx, 4
	mov  rsi, offset env_username
	mov  rdi, offset target
	call copy_count
	mov  rdi, offset username
	call populate_env
	mov  username_length, rcx

	mov  rcx, 5
	mov  rsi, offset env_shell
	mov  rdi, offset target
	call copy_count
	mov  rdi, offset shell_path
	call populate_env
	mov  shell_path_length, rcx

	mov  rcx, 19
	mov  rsi, offset env_desktop
	mov  rdi, offset target
	call copy_count
	mov  rdi, offset desktop
	call populate_env
	mov  desktop_length, rcx

	mov  rcx, 16
	mov  rsi, offset env_session
	mov  rdi, offset target
	call copy_count
	mov  rdi, offset session
	call populate_env
	mov  session_length, rcx

	ret

populate_env:
	mov  rax, r15
	xor  r8, r8
	xor  r9, r9
	xor  r13, r13
	xor  rsi, rsi
	call env_loop
	ret

env_loop:
	mov r14, r8
	add r14, r9
	mov bl, [rax + r14]

	cmp bl, [target + r9]
	je  char_matched

	xor rsi, rsi

	test bl, bl
	je   check_zero

skip_env:
	xor r13, r13
	inc r9

	mov r14, r8
	add r14, r9
	mov bl, [rax + r14]

	test bl, bl
	jne  skip_env

	inc r13
	inc r8
	add r8, r9
	xor r9, r9
	jmp env_loop

char_matched:
	inc r9

	inc rsi
	cmp rsi, rcx
	jne env_loop

	mov r14, r8
	add r14, r9
	add r14, rax
	inc r14

	mov  rsi, r14
	call copy_null
	ret

check_zero:
	cmp r13, 1
	jne skip_env
	ret
