colors_label: .ascii "Colors    "

print_colors:
	mov  rsi, offset colors_symbol
	mov  rcx, 5
	call print

	mov  rsi, offset accent1
	mov  rcx, 5
	call print

	mov  rsi, offset colors_label
	mov  rcx, 10
	call print

	mov  rsi, offset separator_symbol
	mov  rcx, 8
	call print

	mov  rsi, offset blue
	call print_circle
	mov  rsi, offset cyan
	call print_circle
	mov  rsi, offset green
	call print_circle
	mov  rsi, offset yellow
	call print_circle
	mov  rsi, offset red
	call print_circle
	mov  rsi, offset purple
	call print_circle

	mov byte ptr [r10], '\n'
	inc r10

	ret

print_circle:
	mov  rcx, 5
	call print
	mov  rsi, offset circle_symbol
	mov  rcx, 5
	call print
	ret
