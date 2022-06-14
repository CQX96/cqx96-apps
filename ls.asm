;@DESC List all files
;@NAME LS

; LS.ASM
; For the CQX96 Kernel





bits 16
	%INCLUDE "cqx.inc"
org 40960

list:
	call newline
	mov cx,	0

	mov ax, dirlist			; Get list of files on disk
	call os_get_file_list

	mov si, dirlist

.set_column:
	call os_get_cursor_pos

	mov ax, cx
	and al, 0x03
	mov bl, 20
	mul bl

	mov dl, al
	call os_move_cursor ; Put the cursor in the correct column.

	mov ah, 0Eh			; Teletype function from BIOS
.next_char:
	lodsb

	cmp al, ','
	je .next_filename

	cmp al, 0
	je .done

	int 10h
	jmp .next_char

.next_filename:
	inc cx

	mov ax, cx
	and ax, 03h

	cmp ax, 0			; New line every 4th filename.
	jne .set_column

	call newline
	jmp .set_column

.done:
	call newline
	ret
	
	
	dirlist			times 1024 db 0
	
os_move_cursor:
	pusha

	mov bh, 0
	mov ah, 2
	int 10h				; BIOS interrupt to move cursor

	popa
	ret
	
os_get_cursor_pos:
	pusha

	mov bh, 0
	mov ah, 3
	int 10h				; BIOS interrupt to get cursor position

	mov [.tmp], dx
	popa
	mov dx, [.tmp]
	ret


	.tmp dw 0
