memory_label: .ascii "Memory       "

.lcomm data_number_buf, 10

print_memory:
	mov  rsi, offset memory_symbol
	mov  rcx, 6
	call print

	mov  rsi, offset memory_label
	mov  rcx, 13
	call print

	mov  rsi, offset reset
	mov  rcx, 4
	call print

	mov  rsi, offset separator_symbol
	mov  rcx, 4
	call print

	mov  rax, memtotal
	sub  rax, memavailable
	mov  r8, rax
	call print_memory_number

	mov  rsi, offset data_number_label_0
	mov  rcx, 7
	call print

	mov  rax, memtotal
	call print_memory_number

	mov  rsi, offset data_number_label_1
	mov  rcx, 6
	call print

	mov  rsi, offset cyan
	mov  rcx, 5
	call print

	mov  rax, r8
	imul rax, 100
	mov  rbx, memtotal
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

print_memory_number:
	imul rax, 1000
	mov  rbx, 1024 * 1024
	xor  rdx, rdx
	div  rbx
	mov  rbx, 10
	mov  rdi, offset data_number_buf
	call itoa

	add  rsi, offset data_number_buf
	sub  rcx, 3
	test rcx, rcx
	je   print_memory_zero
	call print

print_memory_decimal:
	mov  bl, 46
	call printc

	mov  rcx, 2
	call print

	ret

print_memory_zero:
	mov  bl, 48
	call printc
	jmp  print_memory_decimal
