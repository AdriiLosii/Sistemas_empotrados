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
	.file	"exemplo_4_if_then_complexo.c"
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
	cmp	r3, #20	@ Compara el contenido de r3 y el número 20 (check condición)
	ble	.L2		@ Salta a la etiqueta .L2 si el contenido de r3 es menor o igual a 20 (branch if lower or equal)
	ldr	r3, .L4
	ldr	r3, [r3]
	cmp	r3, #24	@ Si la condición anterior no se cumple, compara el contenido de r3 y el número 24 (check condición)
	bgt	.L2		@ Salta a la etiqueta .L2 si el contenido de r3 es mayor que 24 (branch if greater than)
	ldr	r3, .L4+4
	movs	r2, #1		@ Si ninguna de las 2 condiciones anteriores se cumple, se le asigna el valor 1 a r2
	str	r2, [r3]
.L2:
	movs	r3, #0
	mov	r0, r3
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr		@ Fin del programa
.L5:
	.align	2
.L4:
	.word	x
	.word	a
	.size	main, .-main
	.ident	"GCC: (Arm GNU Toolchain 12.2.Rel1 (Build arm-12.24)) 12.2.1 20221205"
