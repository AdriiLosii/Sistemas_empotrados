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
	.file	"exemplo_9_continue.c"
	.text
	.bss
	.align	2
i:
	.space	4
	.size	i, 4
	.align	2
sum:
	.space	4
	.size	sum, 4
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
	ldr	r3, .L8
	movs	r2, #0
	str	r2, [r3]
	b	.L2
.L5:
	ldr	r3, .L8
	ldr	r3, [r3]
	cmp	r3, #5		@ Compara el registro 3 y el num. 5 (check condición)
	beq	.L7		@ Sale del bucle (branch if equal)
	ldr	r3, .L8+4
	ldr	r2, [r3]
	ldr	r3, .L8
	ldr	r3, [r3]
	add	r3, r3, r2
	ldr	r2, .L8+4
	str	r3, [r2]
	b	.L4		@ fin loop
.L7:
	nop
.L4:
	ldr	r3, .L8
	ldr	r3, [r3]
	adds	r3, r3, #1
	ldr	r2, .L8
	str	r3, [r2]
.L2:
	ldr	r3, .L8
	ldr	r3, [r3]
	cmp	r3, #9		@ Compara el registro 3 y el num. 9 (check condición)
	ble	.L5		@ Sale del bucle (branch if lower or equal)
	movs	r3, #0
	mov	r0, r3
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr		@ fin loop
.L9:
	.align	2
.L8:
	.word	i
	.word	sum
	.size	main, .-main
	.ident	"GCC: (Arm GNU Toolchain 12.2.Rel1 (Build arm-12.24)) 12.2.1 20221205"
