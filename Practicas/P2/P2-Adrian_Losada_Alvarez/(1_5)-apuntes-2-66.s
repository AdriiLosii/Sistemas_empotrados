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
	.file	"apuntes-2-66.c"
	.text
	.global	a
	.data
	.type	a, %object
	.size	a, 1		@ Instrucción para extender ceros
a:
	.byte	-1
	.global	b
	.align	1
	.type	b, %object
	.size	b, 2		@ Instrucción para extender ceros
b:
	.short	-2
	.global	c
	.bss
	.align	2
	.type	c, %object
	.size	c, 4		@ Instrucción para extender ceros
c:
	.space	4
	.global	d
	.data
	.type	d, %object
	.size	d, 1		@ Instrucción para extender ceros
d:
	.byte	1
	.global	e
	.bss
	.align	2
	.type	e, %object
	.size	e, 4		@ Instrucción para extender ceros
e:
	.space	4
	.text
	.align	1
	.global	main
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
	ldrb	r3, [r3]
	sxtb	r3, r3		@ Instrucción para extender el signo
	movs	r2, r3
	ldr	r3, .L3+4
	str	r2, [r3]
	ldr	r3, .L3+8
	movs	r2, #0
	ldrsh	r3, [r3, r2]
	movs	r2, r3
	ldr	r3, .L3+4
	str	r2, [r3]
	ldr	r3, .L3+12
	ldrb	r3, [r3]
	movs	r2, r3
	ldr	r3, .L3+16
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
	.word	d
	.word	e
	.size	main, .-main
	.ident	"GCC: (Arm GNU Toolchain 12.2.Rel1 (Build arm-12.24)) 12.2.1 20221205"
