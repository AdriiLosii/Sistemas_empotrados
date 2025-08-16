	.data

a:	.word 3
res:	.space 4

	.text

main:	ldr r0, =a
	ldr r0, [r0]	@ N*1

	mov r1, r0

	lsl r0, #3	@ N*8
	add r1, r0	@ N*8+N*1=N*9

	lsl r0, #1	@ N*8*2=N*16
	add r1, r0	@ N*16+N*9=N*25
	ldr r2, =res
	str r0, [r2]

end:	wfi
