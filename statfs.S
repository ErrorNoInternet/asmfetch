statfs_path: .asciz "/"

.lcomm fs_bsize, 8
.lcomm fs_blocks, 8
.lcomm fs_bfree, 8

.lcomm statfs_buf, 128

populate_statfs:
	mov rax, SYS_STATFS
	mov rdi, offset statfs_path
	mov rsi, offset statfs_buf
	syscall

	mov rax, [statfs_buf + 8]
	mov [fs_bsize], rax

	mov rax, [statfs_buf + 16]
	mov [fs_blocks], rax

	mov rax, [statfs_buf + 24]
	mov [fs_bfree], rax

	ret
