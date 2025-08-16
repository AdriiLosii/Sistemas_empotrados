	.cpu cortex-m3
	.arch armv7-m
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"exemplo_3_if_then.c"
	.text
	.data
	.align	2
	.type	x, %object
	.size	x, 4
x:
	.word	1
	.align	2
	.type	a, %object
	.size	a, 4
a:
	.word	32
	.text
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	add	r7, sp, #0
	ldr	r3, .L4
	ldr	r3, [r3]
	cmp	r3, #0		@ Compara el registro 3 y el 0 (check condición)
	bge	.L2		@ Sale del bucle (branch if greater or equal)
	ldr	r3, .L4
	ldr	r3, [r3]
	rsbs	r3, r3, #0
	ldr	r2, .L4
	str	r3, [r2]
.L2:
	ldr	r3, .L4+4
	ldr	r3, [r3]
	adds	r3, r3, #1
	ldr	r2, .L4+4
	str	r3, [r2]
	movs	r3, #0
	mov	r0, r3
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr		@ fin loop
.L5:
	.align	2
.L4:
	.word	a
	.word	x
	.size	main, .-main
	.ident	"GCC: (Arm GNU Toolchain 12.2.Rel1 (Build arm-12.24)) 12.2.1 20221205"
