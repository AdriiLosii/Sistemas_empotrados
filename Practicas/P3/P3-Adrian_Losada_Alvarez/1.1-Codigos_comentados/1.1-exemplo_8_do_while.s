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
	.file	"exemplo_8_do_while.c"
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
	ldr	r3, .L4+4
	ldr	r3, [r3]
.L2:
	add	r2, r2, r3	@ Suma el contenido de r2 (sum) y el de r3 (i) y lo almacena en r2 (sum += i)
	subs	r3, r3, #1	@ Reduce el valor del contenido de r3 (i) en 1 (i--)
	cmp	r3, #0		@ Compara el contenido de r3 con el número 0 (check condición)
	bgt	.L2		@ Salta a la etiqueta .L2 si el valor de r3 es mayor que 0 (branch if greater than)
	ldr	r1, .L4	@ Si la condición no se cumple, el programa finaliza
	str	r2, [r1]
	ldr	r2, .L4+4
	str	r3, [r2]
	movs	r0, #0
	bx	lr		@ Fin del programa
.L5:
	.align	2
.L4:
	.word	.LANCHOR0
	.word	.LANCHOR1
	.size	main, .-main
	.data
	.align	2
	.set	.LANCHOR1,. + 0
	.type	i, %object
	.size	i, 4
i:
	.word	10
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	sum, %object
	.size	sum, 4
sum:
	.space	4
	.ident	"GCC: (Arm GNU Toolchain 12.2.Rel1 (Build arm-12.24)) 12.2.1 20221205"
