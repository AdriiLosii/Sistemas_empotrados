	.cpu cortex-a7
	.arch armv7-a
	.arch_extension virt
	.arch_extension idiv
	.arch_extension sec
	.arch_extension mp
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
	.file	"suma_1-5.c"
	.text
	.global	a
	.data
	.align	2
	.type	a, %object
	.size	a, 4
a:
	.word	7
	.global	b
	.align	2
	.type	b, %object
	.size	b, 4
b:
	.word	5
	.global	c
	.bss
	.align	2
	.type	c, %object
	.size	c, 4
c:
	.space	4
	.text
	.align	2
	.syntax unified
	.arm
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	movw	r3, #:lower16:a
	movt	r3, #:upper16:a
	ldr	r2, [r3]
	movw	r3, #:lower16:b
	movt	r3, #:upper16:b
	ldr	r3, [r3]
	add	r2, r2, r3
	movw	r3, #:lower16:c
	movt	r3, #:upper16:c
	str	r2, [r3]
	mov	r3, #0
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	main, .-main
	.ident	"GCC: (Arm GNU Toolchain 12.2.Rel1 (Build arm-12.24)) 12.2.1 20221205"
