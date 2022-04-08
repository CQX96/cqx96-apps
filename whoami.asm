org 40960     ; Applications have org 40960 but
              ; shells have org 32768
whoami:
	call 0009h	; Kernel API: NEWLINE
	call 0042h	; Kernel API: GET_USERNAME
	mov ax, si
	call 0045h	; Kernel API: STRING_UPPERCASE
	mov si, ax
	call 0003h	; Kernel API: PRINT_SI
ret
