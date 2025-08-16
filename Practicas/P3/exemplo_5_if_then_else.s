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
	.file	"exemplo_5_if_then_else.c"
	.text
	.bss
	.align	2
a:
	.space	4
	.size	a, 4
	.align	2
b:
	.space	4
	.size	b, 4
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
	ldr	r3, .L5
	ldr	r3, [r3]
	cmp	r3, #1		@ Compara el registro 3 y el num. 1 (check condición)
	bne	.L2		@ Sale del bucle (branch if not equal)
	ldr	r3, .L5+4
	movs	r2, #3
	str	r2, [r3]
	b	.L3		@ fin loop
.L2:
	ldr	r3, .L5+4
	movs	r2, #4
	str	r2, [r3]
.L3:
	movs	r3, #0
	mov	r0, r3
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr		@ fin loop
.L6:
	.align	2
.L5:
	.word	a
	.word	b
	.size	main, .-main
	.ident	"GCC: (Arm GNU Toolchain 12.2.Rel1 (Build arm-12.24)) 12.2.1 20221205"
