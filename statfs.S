statfs_path: .asciz "/"

.lcomm statfs_buf, 128

statfs:
	mov rax, SYS_STATFS
	mov rdi, offset statfs_path
	mov rsi, offset statfs_buf
	syscall

	ret
