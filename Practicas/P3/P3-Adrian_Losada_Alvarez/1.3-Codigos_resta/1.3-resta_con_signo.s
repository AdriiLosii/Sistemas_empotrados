	.data

a:	.word -9
b:	.word -6
c:	.space 4

	.text
main:	ldr r0, =a
	ldr r0, [r0]
	ldr r1, =b
	ldr r1, [r1]
	ldr r2, =c

	cmp r0, r1		@ Compara a y b
	bhs resta_ab		@ Si a>=b, salta a la etiqueta resta_ab
	sub r2, r1, r0		@ Si a<b, no salta a la etiqueta y opera b-a
	b fin			@ Saltamos a la etiqueta fin

resta_ab:			@ Etiqueta que opera a-b
	sub r2, r0, r1

fin:				@ En esta etiqueta almacenamos el resultado en c
	str r2, [r2]


stop:	wfi
