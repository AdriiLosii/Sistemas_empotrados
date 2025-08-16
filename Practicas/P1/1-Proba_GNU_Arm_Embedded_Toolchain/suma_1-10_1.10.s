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
	.file	"suma_1-10.c"
	.text
	.data
	.align	2
	.type	a, %object
	.size	a, 4
a:
	.word	1
	.align	2
	.type	b, %object
	.size	b, 4
b:
	.word	2
	.bss
	.align	2
c:
	.space	4
	.size	c, 4
	.text
	.align	1
	.global	main
	.syntax unified
	.code	16
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L3
	ldr	r2, [r3]
	ldr	r3, .L3+4
	ldr	r3, [r3]
	adds	r2, r2, r3
	ldr	r3, .L3+8
	str	r2, [r3]
.L2:
	b	.L2
.L4:
	.align	2
.L3:
	.word	a
	.word	b
	.word	c
	.size	main, .-main
	.ident	"GCC: (Arm GNU Toolchain 12.2.Rel1 (Build arm-12.24)) 12.2.1 20221205"
