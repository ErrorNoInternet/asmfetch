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

parse_envs:
	mov  rsi, 4
	mov  rdx, offset env_username
	mov  rdi, offset username
	call find_env_var
	mov  username_length, rcx
	xor  rcx, rcx

	mov  rsi, 5
	mov  rdx, offset env_shell
	mov  rdi, offset shell_path
	call find_env_var
	mov  shell_path_length, rcx
	xor  rcx, rcx

	mov  rsi, 19
	mov  rdx, offset env_desktop
	mov  rdi, offset desktop
	call find_env_var
	mov  desktop_length, rcx
	xor  rcx, rcx

	mov  rsi, 16
	mov  rdx, offset env_session
	mov  rdi, offset session
	call find_env_var
	mov  session_length, rcx

	ret

find_env_var:
	mov rax, [rbp]
	xor r8, r8
	xor r9, r9

env_match_loop:
	mov bl, [rax + r9]
	cmp bl, [rdx + r9]
	je  env_char_matched
	xor r9, r9

	inc r8
	mov rax, [rbp + r8 * 8]

	test rax, rax
	jne  env_match_loop

	ret

env_char_matched:
	inc r9
	cmp r9, rsi
	jne env_match_loop

	mov  rsi, rax
	add  rsi, r9
	inc  rsi
	call copy_null

	ret
