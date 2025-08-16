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
	.file	"1.4-suma_por_referencia.c"
	.text
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	suma, %function
suma:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}
	sub	sp, sp, #20
	add	r7, sp, #0
	str	r0, [r7, #12]	@ Se cargan los valores pasados en los registros r0, r1 y r2
	str	r1, [r7, #8]
	str	r2, [r7, #4]
	ldr	r2, [r7, #12]	@ Se cargan los valores guardados en memoria en r2 y r3
	ldr	r3, [r7, #8]
	add	r2, r2, r3	@ Se suman los valores y se almacenan en r2
	ldr	r3, [r7, #4]	@ Desapila la dirección de memoria de c
	str	r2, [r3]	@ Guarda el resultado de c
	nop
	mov	r0, r3
	adds	r7, r7, #20
	mov	sp, r7
	@ sp needed
	pop	{r7}
	bx	lr
	.size	suma, .-suma
	.align	1
	.global	main
	.syntax unified
	.thumb
	.thumb_func
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r7, lr}
	sub	sp, sp, #16
	add	r7, sp, #0
	movs	r3, #5
	str	r3, [r7, #12]
	movs	r3, #10
	str	r3, [r7, #8]	@ Hasta aqui hace lo mismo: inicializar los valores y guardarlos en memoria
	adds	r3, r7, #4	@ Recupera la DIRECCIÓN de memoria del resultado
	mov	r2, r3		@ Mueve el valor de r3 a r2
	ldr	r1, [r7, #8]	@ Recupera el valor guardado anteriormente (10) en esa dirección de memoria
	ldr	r0, [r7, #12]	@ Recupera el valor guardado anteriormente (5) en esa dirección de memoria
	bl	suma
	movs	r3, #0		@ Esto es igual, guarda el resultado en memoria
	mov	r0, r3
	adds	r7, r7, #16
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
	.size	main, .-main
	.ident	"GCC: (Arm GNU Toolchain 12.2.Rel1 (Build arm-12.24)) 12.2.1 20221205"
