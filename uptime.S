uptime_label:   .ascii "Uptime       "
days_label:     .ascii " days"
day_label:      .ascii " day"
hours_label:    .ascii " hours"
hour_label:     .ascii " hour"
minutes_label:  .ascii " minutes"
minute_label:   .ascii " minute"
comma_label:    .ascii ", "

.lcomm days_str, 10
.lcomm hours_str, 10
.lcomm minutes_str, 10

print_uptime:
	mov  rsi, offset uptime_symbol
	mov  rcx, 5
	call print

	mov  rsi, offset uptime_label
	mov  rcx, 13
	call print

	mov  rsi, offset reset
	mov  rcx, 4
	call print

	mov  rsi, offset separator_symbol
	mov  rcx, 4
	call print

	xor r9, r9

	mov  rax, days
	test rax, rax
	jne  print_days

uptime_hours:
	mov  rax, hours
	test rax, rax
	jne  print_hours

uptime_minutes:
	mov  rax, minutes
	test rax, rax
	jne  print_minutes

uptime_done:
	mov  bl, 10
	call printc
	ret

print_day_label:
	mov  rsi, offset day_label
	mov  rcx, 4
	call print
	jmp  uptime_hours

print_days:
	inc r9

	mov  rdi, offset days_str
	mov  rbx, 10
	mov  r8, rax
	call itoa
	add  rsi, offset days_str
	call print

	cmp r8, 1
	je  print_day_label

	mov  rsi, offset days_label
	mov  rcx, 5
	call print

	jmp uptime_hours

print_hour_label:
	mov  rsi, offset hour_label
	mov  rcx, 5
	call print
	jmp  uptime_minutes

print_hours:
	test r9, r9
	je   print_hours_
	inc  r9

	mov  rsi, offset comma_label
	mov  rcx, 2
	call print

print_hours_:
	mov  rdi, offset hours_str
	mov  rbx, 10
	mov  r8, rax
	call itoa
	add  rsi, offset hours_str
	call print

	cmp r8, 1
	je  print_hour_label

	mov  rsi, offset hours_label
	mov  rcx, 6
	call print

	jmp uptime_minutes

print_minute_label:
	mov  rsi, offset minute_label
	mov  rcx, 7
	call print
	jmp  uptime_done

print_minutes:
	test r9, r9
	je   print_minutes_
	inc  r9

	mov  rsi, offset comma_label
	mov  rcx, 2
	call print

print_minutes_:
	mov  rdi, offset minutes_str
	mov  rbx, 10
	mov  r8, rax
	call itoa
	add  rsi, offset minutes_str
	call print

	cmp r8, 1
	je  print_minute_label

	mov  rsi, offset minutes_label
	mov  rcx, 8
	call print

	jmp uptime_done
