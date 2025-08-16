	.cpu cortex-m3
	.arch armv7-m
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 1
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"exemplo_6_for.c"
	.text
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L4
	ldr	r2, [r3]
	movs	r3, #0
.L2:
	add	r2, r2, r3
	adds	r3, r3, #1
	cmp	r3, #10	@ compara (check condición)
	bne	.L2		@ (branch if not equal)
	ldr	r3, .L4
	str	r2, [r3]
	movs	r2, #10
	str	r2, [r3, #4]
	movs	r0, #0
	bx	lr		@ fin loop
.L5:
	.align	2
.L4:
	.word	.LANCHOR0
	.size	main, .-main
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	sum, %object
	.size	sum, 4
sum:
	.space	4
	.type	i, %object
	.size	i, 4
i:
	.space	4
	.ident	"GCC: (Arm GNU Toolchain 12.2.Rel1 (Build arm-12.24)) 12.2.1 20221205"
