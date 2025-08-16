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
	.file	"exemplo_10_break.c"
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
	push	{r4, r5}
	ldr	r3, .L6
	ldr	r5, [r3]
	ldrb	r3, [r5]	@ zero_extendqisi2
	cbz	r3, .L2
	ldr	r3, .L6+4
	ldr	r4, [r3]
	adds	r3, r5, #1
.L3:
	mov	r2, r3
	adds	r3, r3, #1
	ldrb	r1, [r2]	@ zero_extendqisi2
	cmp	r1, #0		@ Compara el contenido de r1 y el número 0 (check condición)
	bne	.L3		@ Salta a la etiqueta .L3 si el contenido de r1 no es igual a 0 (branch if not equal)
	ldr	r3, .L6
	str	r2, [r3]
	subs	r3, r4, r5
	add	r3, r3, r2
	ldr	r2, .L6+4
	str	r3, [r2]
.L2:
	movs	r0, #0
	pop	{r4, r5}
	bx	lr		@ Fin del programa
.L7:
	.align	2
.L6:
	.word	.LANCHOR0
	.word	.LANCHOR1
	.size	main, .-main
	.data
	.align	2
	.set	.LANCHOR0,. + 0
	.type	p, %object
	.size	p, 4
p:
	.word	str
	.type	str, %object
	.size	str, 6
str:
	.ascii	"hello\000"
	.bss
	.align	2
	.set	.LANCHOR1,. + 0
	.type	len, %object
	.size	len, 4
len:
	.space	4
	.ident	"GCC: (Arm GNU Toolchain 12.2.Rel1 (Build arm-12.24)) 12.2.1 20221205"
