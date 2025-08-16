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
	.file	"exemplo_2_if_then_else_consigno.c"
	.text
	.data
	.align	2
	.type	x, %object
	.size	x, 4
x:
	.word	1
	.align	2
	.type	y, %object
	.size	y, 4
y:
	.word	-1
	.bss
	.align	2
z:
	.space	4
	.size	z, 4
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
	ldr	r2, [r3]
	ldr	r3, .L5+4
	ldr	r3, [r3]
	cmp	r2, r3		@ Compara los registros 2 y 3 (check condición)
	ble	.L2		@ Sale del bucle (branch if lesser or equal)
	ldr	r3, .L5+8
	movs	r2, #1
	str	r2, [r3]
	b	.L3		@ fin loop
.L2:
	ldr	r3, .L5+8
	movs	r2, #0
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
	.word	x
	.word	y
	.word	z
	.size	main, .-main
	.ident	"GCC: (Arm GNU Toolchain 12.2.Rel1 (Build arm-12.24)) 12.2.1 20221205"
