.lcomm print_buf, 1024

print:
	mov rdi, r10
	rep movsb
	mov r10, rdi

	ret

println:
	mov rdi, r10
	rep movsb
	mov r10, rdi

	mov byte ptr [r10], '\n'
	inc r10

	ret
