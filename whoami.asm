org 40960     ; Applications have org 40960 but
              ; shells have org 32768
whoami:
	call 0009h
	call 0042h
	mov ax, si
	call 0045h
	mov si, ax
	call 0003h
ret
