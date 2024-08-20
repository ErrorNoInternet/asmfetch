storage_label: .ascii "Storage (/)  "

.lcomm storage_number_buf, 10

print_storage:
	mov  rsi, offset storage_symbol
	mov  rcx, 6
	call print

	mov  rsi, offset storage_label
	mov  rcx, 13
	call print

	mov  rsi, offset reset
	mov  rcx, 4
	call print

	mov  rsi, offset separator_symbol
	mov  rcx, 4
	call print

	mov  rax, fs_blocks
	sub  rax, fs_bfree
	mov  r8, rax
	call print_storage_number

	mov  rsi, offset data_number_label_0
	mov  rcx, 7
	call print

	mov  rax, fs_blocks
	call print_storage_number

	mov  rsi, offset data_number_label_1
	mov  rcx, 6
	call print

	mov  rsi, offset cyan
	mov  rcx, 5
	call print

	mov  rax, r8
	imul rax, 100
	mov  rbx, fs_blocks
	xor  rdx, rdx
	div  rbx
	mov  rbx, 10
	mov  rdi, offset data_number_buf
	call itoa

	add  rsi, offset data_number_buf
	call print

	mov  bl, 37
	call printc

	mov  rsi, offset reset
	mov  rcx, 4
	call print

	mov  rsi, offset data_number_label_2
	mov  rcx, 2
	call print

	ret

print_storage_number:
	imul rax, fs_bsize
    imul rax, 1000
	mov  rbx, 1024 * 1024 * 1024
	xor  rdx, rdx
	div  rbx
	mov  rbx, 10
	mov  rdi, offset storage_number_buf
	call itoa

	add  rsi, offset storage_number_buf
	sub  rcx, 3
	test rcx, rcx
	je   print_storage_zero
	call print

print_storage_decimal:
	mov  bl, 46
	call printc

	mov  rcx, 2
	call print

	ret

print_storage_zero:
	mov  bl, 48
	call printc
	jmp  print_storage_decimal
