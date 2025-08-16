	.cpu cortex-m0
	.arch armv6s-m
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"operaciones_logicas.c"
	.text
	.global	a
	.data
	.align	2
	.type	a, %object
	.size	a, 4
a:
	.word	1
	.global	b
	.align	2
	.type	b, %object
	.size	b, 4
b:
	.word	1
	.global	c
	.bss
	.align	2
	.type	c, %object
	.size	c, 4
c:
	.space	4
	.text
	.align	1
	.syntax unified
	.code	16
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	add	r7, sp, #0
	ldr	r3, .L3
	ldr	r3, [r3]
	mvns	r2, r3		@ Op. lógica NOT
	ldr	r3, .L3+4
	str	r2, [r3]
	ldr	r3, .L3
	ldr	r2, [r3]
	ldr	r3, .L3+8
	ldr	r3, [r3]
	ands	r2, r3		@ Op. lógica AND
	ldr	r3, .L3+4
	str	r2, [r3]
	ldr	r3, .L3
	ldr	r2, [r3]
	ldr	r3, .L3+8
	ldr	r3, [r3]
	orrs	r2, r3		@ Op. lógica OR
	ldr	r3, .L3+4
	str	r2, [r3]
	ldr	r3, .L3
	ldr	r2, [r3]
	ldr	r3, .L3+8
	ldr	r3, [r3]
	eors	r2, r3		@ Op. lógica XOR
	ldr	r3, .L3+4
	str	r2, [r3]
	movs	r3, #0
	movs	r0, r3
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
.L4:
	.align	2
.L3:
	.word	a
	.word	c
	.word	b
	.size	main, .-main
	.ident	"GCC: (Arm GNU Toolchain 12.2.Rel1 (Build arm-12.24)) 12.2.1 20221205"
