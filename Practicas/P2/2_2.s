	.data

a:	.word 4
b:	.byte -3
c:	.byte 2

	.text

main:	ldr r0, =b
	ldrb r0, [r0]
	sxtb r0, r0
	ldr r1, =c
	ldrb r1, [r1]
	add r2, r0, r1
	ldr r0, =a
	strb r2, [r0]

end:	wfi
