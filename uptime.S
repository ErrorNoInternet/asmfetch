uptime_label:   .ascii "Uptime    "
days_label:     .ascii " days"
hours_label:    .ascii " hours"
minutes_label:  .ascii " minutes"
comma_label:    .ascii ", "

.lcomm days_str, 10
.lcomm hours_str, 10
.lcomm minutes_str, 10

print_uptime:
	mov  rsi, offset uptime_symbol
	mov  rcx, 5
	call print

	mov  rsi, offset accent1
	mov  rcx, 5
	call print

	mov  rsi, offset uptime_label
	mov  rcx, 10
	call print

	mov  rsi, offset separator_symbol
	mov  rcx, 8
	call print

	xor r9, r9

	mov  rax, days
	test rax, rax
	jne  print_days

uptime_hours:
	mov  rax, hours
	test rax, rax
	jne  print_comma_hours

uptime_minutes:
	mov rax, minutes

	test r9, r9
	je   print_minutes

	test rax, rax
	jne  print_comma_minutes

uptime_done:
	mov  bl, '\n'
	call printc
	ret

print_day_label:
	mov rcx, 4
	jmp print_days_label

print_days:
	inc r9

	mov  rdi, offset days_str
	mov  rbx, 10
	mov  r8, rax
	call itoa
	add  rsi, offset days_str
	call print

	mov rsi, offset days_label
	cmp r8, 1
	je  print_day_label
	mov rcx, 5

print_days_label:
	call print
	jmp  uptime_hours

print_hour_label:
	mov rcx, 5
	jmp print_hours_label

print_comma_hours:
	test r9, r9
	je   print_hours

	mov  rsi, offset comma_label
	mov  rcx, 2
	call print

print_hours:
	inc r9

	mov  rdi, offset hours_str
	mov  rbx, 10
	mov  r8, rax
	call itoa
	add  rsi, offset hours_str
	call print

	mov rsi, offset hours_label
	cmp r8, 1
	je  print_hour_label
	mov rcx, 6

print_hours_label:
	call print
	jmp  uptime_minutes

print_minute_label:
	mov rcx, 7
	jmp print_minutes_label

print_comma_minutes:
	test r9, r9
	je   print_minutes

	mov  rsi, offset comma_label
	mov  rcx, 2
	call print

print_minutes:
	mov  rdi, offset minutes_str
	mov  rbx, 10
	mov  r8, rax
	call itoa
	add  rsi, offset minutes_str
	call print

	mov rsi, offset minutes_label
	cmp r8, 1
	je  print_minute_label
	mov rcx, 8

print_minutes_label:
	call print
	jmp  uptime_done
