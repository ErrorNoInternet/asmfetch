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
	mov  rcx, 4
	mov  rsi, offset env_username
	mov  rdi, offset target
	call copy_count
	mov  rdi, offset username
	call find_env_var
	mov  username_length, rcx

	mov  rcx, 5
	mov  rsi, offset env_shell
	mov  rdi, offset target
	call copy_count
	mov  rdi, offset shell_path
	call find_env_var
	mov  shell_path_length, rcx

	mov  rcx, 19
	mov  rsi, offset env_desktop
	mov  rdi, offset target
	call copy_count
	mov  rdi, offset desktop
	call find_env_var
	mov  desktop_length, rcx

	mov  rcx, 16
	mov  rsi, offset env_session
	mov  rdi, offset target
	call copy_count
	mov  rdi, offset session
	call find_env_var
	mov  session_length, rcx

	ret

find_env_var:
	mov rax, [rbp]
	xor r15, r15
	xor r8, r8

env_match_loop:
	mov bl, [rax + r8]

	cmp bl, [target + r8]
	je  env_char_matched

	xor r8, r8
	xor rsi, rsi
	inc r15
	mov rax, [rbp + r15 * 8]

	test rax, rax
	je   find_env_done

	jmp env_match_loop

env_char_matched:
	inc r8
	cmp r8, rcx
	jne env_match_loop

	mov  rsi, rax
	add  rsi, r8
	inc  rsi
	call copy_null

find_env_done:
	ret
