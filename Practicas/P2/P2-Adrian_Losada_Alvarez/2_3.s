	.data

a:	.word 3
res:	.space 4

	.text

main:	ldr r0, =a
	ldr r0, [r0]
	lsl r0, #5
	ldr r1, =res
	str r0, [r1]

end:	wfi
