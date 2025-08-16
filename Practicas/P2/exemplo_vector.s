@
@ This program:
@  + initialices the variables 'a' and 'b' with the numbers 5 and 4, respectivelly,
@  + loads the contents of the variables 'a' and 'b' on the registers r0 and r1, respectivelly,
@  + adds the contents of these registers, and
@  + stores the result in the variable 'c'.
@

	.data

V:	.word 1, 2, 3, 4, 5
b:	.word 5
res:	.space 20

	.text

main:	ldr r0, =V	@ r0 <- V
	ldr r1, [r0]	@ r1 <- [V]
	ldr r2, =b	@ r1 <- b
	ldr r2, [r2]	@ r1 <- [b]
	ldr r3, =res	@ r3 <- res
	add r4, r1, r2	@ r4 <- r1 + r2
	str r4, [r3,#0]	@ [res(0)] <- V(0)+ b
	ldr r1, [r0,#4]	@ r1 <- [V(1)]
	add r4, r1, r2	@ r4 <- r1 + r2
	str r4, [r3,#4]	@ [res(1)] <- V(1)+ b
	ldr r1, [r0,#8]	@ r1 <- [V(2)]
	add r4, r1, r2	@ r4 <- r1 + r2
	str r4, [r3,#8]	@ [res(2)] <- V(2)+ b
	ldr r1, [r0,#12]	@ r1 <- [V(3)]
	add r4, r1, r2	@ r4 <- r1 + r2
	str r4, [r3,#12]	@ [res(3)] <- V(3)+ b
	ldr r1, [r0,#16]	@ r1 <- [V(4)]
	add r4, r1, r2	@ r4 <- r1 + r2
	str r4, [r3,#16]	@ [res(4)] <- V(4)+ b

end:	wfi		@ End of program
