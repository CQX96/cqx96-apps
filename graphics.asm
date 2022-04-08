; Graphics mode testing


org 40960
program:
	call 0048h
	mov di,50+320*10
  mov cx,127
	call 004Bh
	db "Graphics!!!", 0
	xor ah, ah
	int 16h
	call 004Eh
ret
