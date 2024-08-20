colors_label: .ascii "Colors       "

print_colors:
	mov  rsi, offset colors_symbol
	mov  rcx, 5
	call print

	mov  rsi, offset colors_label
	mov  rcx, 13
	call print

	mov  rsi, offset reset
	mov  rcx, 4
	call print

	mov  rsi, offset separator_symbol
	mov  rcx, 4
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

	mov  bl, 10
	call printc

	ret

print_circle:
	mov  rcx, 5
	call print
	mov  rsi, offset circle_symbol
	mov  rcx, 5
	call print
	ret
