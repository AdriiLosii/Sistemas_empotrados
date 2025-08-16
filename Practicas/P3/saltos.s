	.text
main:	b  salto
	b  salto
	b  salto
	b  salto
salto:	mov r0, r0
	mov r1, r1
	b   salto
	b   salto

stop:	wfi
