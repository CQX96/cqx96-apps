org 40960

uname:
	call 0009h        ; Kernel API: NEWLINE
	call 0051h        ; Kernel API: GET_UNAME
	call 0003h        ; Kernel API: PRINT_SI
ret
