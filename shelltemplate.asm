; THIS IS A SHELL TEMPLATE. YOU CAN USE IT TO CREATE YOUR
; OWN CQX96 SHELL.

org 32768
shell:
	call 0009h      ; Kernel API: NEWLINE
	mov si, bracket
	call 0003h      ; Kernel API: PRINT_SI
	call 0042h      ; Kernel API: GET_USERNAME
	mov ax, si
	call 0045h	    ; Kernel API: STRING_UPPERCASE
	mov si, ax
	call 0003h      ; Kernel API: PRINT_SI
	mov si, thing
	call 0003h      ; Kernel API: PRINT_SI
	mov ax, input
	mov bx, 64
	call 0012h      ; Kernel API: USER_INPUT
	mov ax, input
	call 001Bh      ; Kernel API: CHOMP
	mov si, input
	mov bx, 0
	mov cx, 40960
	call 0018h
	jc .tryprgext
	mov ax, 0
	mov bx, 0
	mov cx, 0
	mov dx, 0
	mov si, 0
	mov di, 0
	call 40960
  jmp shell
  .tryprgext:
    mov ax, input
	  mov bx, prg
	  mov cx, input
	  call join
	  mov ax, input
	  call 001Bh      ; Kernel API: CHOMP
  	mov si, input
	  mov bx, 0
	  mov cx, 40960
	  call 0018h      ; Kernel API: LOAD_FILE
	  jc exit
	  mov ax, 0
  	mov bx, 0
  	mov cx, 0
	  mov dx, 0
  	mov si, 0
  	mov di, 0
  	call 40960
  jmp shell
exit:
jmp shell
    
join:
	pusha
	mov si, ax			
	mov di, cx
	call 0024h      ; Kernel API: COPY_STR_TO_STR
	call 002Ah      ; Kernel API: GET_LENGTH
	add cx, ax			
	mov si, bx			
	mov di, cx
	call 0024h      ; Kernel API: COPY_STR_TO_STR
	popa
ret

bracket        db "[",0
thing          db "]:",0
input 	       times 64 db 0
prg	       db ".PRG",0
