copy_count:
	xor rax, rax

copy_count_loop:
	mov bl, [rsi + rax]
	mov [rdi + rax], bl

	inc rax
	cmp rax, rcx
	jne copy_count_loop

	ret

copy_null:
	xor rcx, rcx

copy_null_loop:
	mov  bl, [rsi + rcx]
	mov  [rdi + rcx], bl
	inc  rcx
	test bl, bl
	jne  copy_null_loop
	ret
