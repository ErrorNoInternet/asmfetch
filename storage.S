storage_label: .ascii "Storage   "
statfs_path: .asciz "/"

.lcomm statfs_buf, 128

print_storage:
	mov rax, SYS_STATFS
	mov rdi, offset statfs_path
	mov rsi, offset statfs_buf
	syscall

	mov  rsi, offset storage_symbol
	mov  rcx, 6
	call print

	mov  rsi, offset accent1
	mov  rcx, 5
	call print

	mov  rsi, offset storage_label
	mov  rcx, 10
	call print

	mov  rsi, offset separator_symbol
	mov  rcx, 8
	call print

	mov  rax, [statfs_buf + 16]
	test rax, rax
	jne  print_storage_numbers

	mov  rsi, offset unknown_label
	mov  rcx, 7
	call println

	ret

print_storage_numbers:
	sub  rax, [statfs_buf + 24]
	mov  r8, rax
	call print_storage_number

	mov  rsi, offset size_label_0
	mov  rcx, 7
	call print

	mov  rax, [statfs_buf + 16]
	call print_storage_number

	mov  rsi, offset size_label_1
	mov  rcx, 6
	call print

	mov  rsi, offset accent0
	mov  rcx, 5
	call print

	mov  rax, r8
	imul rax, 100
	mov  rbx, [statfs_buf + 16]
	xor  rdx, rdx
	div  rbx
	mov  rbx, 10
	mov  rdi, offset number_buf
	call itoa

	add  rsi, offset number_buf
	call print

	mov byte ptr [r10], '%'
	inc r10

	mov  rsi, offset reset
	mov  rcx, 4
	call print

	mov  rsi, offset size_label_2
	mov  rcx, 2
	call print

	ret

print_storage_number:
	imul rax, [statfs_buf + 8]
	imul rax, 1000
	mov  rbx, 1024 * 1024 * 1024
	xor  rdx, rdx
	div  rbx
	mov  rbx, 10
	mov  rdi, offset number_buf
	call itoa

	add  rsi, offset number_buf
	sub  rcx, 3
	cmp  rcx, 1
	jl   print_storage_zero
	call print

print_storage_decimal:
	mov byte ptr [r10], '.'
	inc r10

	mov  rcx, 2
	call print

	ret

print_storage_zero:
	mov byte ptr [r10], '0'
	inc r10
	jmp print_storage_decimal
