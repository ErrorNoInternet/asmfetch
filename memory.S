memory_label: .ascii "Memory    "

print_memory:
	mov  rsi, offset memory_symbol
	mov  rcx, 6
	call print

	mov  rsi, offset accent1
	mov  rcx, 5
	call print

	mov  rsi, offset memory_label
	mov  rcx, 10
	call print

	mov  rsi, offset separator_symbol
	mov  rcx, 8
	call print

	mov  rax, memtotal
	sub  rax, memavailable
	mov  r8, rax
	call print_memory_number

	mov  rsi, offset size_label_0
	mov  rcx, 7
	call print

	mov  rax, memtotal
	call print_memory_number

	mov  rsi, offset size_label_1
	mov  rcx, 6
	call print

	mov  rsi, offset accent0
	mov  rcx, 5
	call print

	mov  rax, r8
	imul rax, 100
	mov  rbx, memtotal
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

print_memory_number:
	imul rax, 1000
	mov  rbx, 1024 * 1024
	xor  rdx, rdx
	div  rbx
	mov  rbx, 10
	mov  rdi, offset number_buf
	call itoa

	add  rsi, offset number_buf
	sub  rcx, 3
	cmp  rcx, 1
	jl   print_memory_zero
	call print

print_memory_decimal:
	mov byte ptr [r10], '.'
	inc r10

	mov  rcx, 2
	call print

	ret

print_memory_zero:
	mov byte ptr [r10], '0'
	inc r10
	jmp print_memory_decimal
