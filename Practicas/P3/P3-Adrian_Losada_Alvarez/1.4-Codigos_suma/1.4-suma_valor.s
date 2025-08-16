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
	.file	"1.4-suma_normal.c"
	.text
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	suma, %function
suma:				@ Subrutina
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r7}		@ Apila la pila en el registro r7 y la direccion de memoria de retorno
	sub	sp, sp, #12	@ Guarda espacio en la pila para las variables que vaya a usar
	add	r7, sp, #0
	str	r0, [r7, #4]
	str	r1, [r7]	@ Guarda el valor de 
	ldr	r2, [r7, #4]
	ldr	r3, [r7]
	add	r3, r3, r2	@ Suma los dos valores y almacena el resultado en r3
	mov	r0, r3		@ Mueve el resultado de r3 a r0
	adds	r7, r7, #12
	mov	sp, r7
	@ sp needed
	pop	{r7}		@ Desapila r7 y copia la dirección de retorno en el contador del programa
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
	add	r7, sp, #0	@ Guarda el valor del puntero de pila en r7
	movs	r3, #5		@ Mueve el valor 5 a r3
	str	r3, [r7, #12]	@ Guarda el valor de r3 en la dirección de memoria
	movs	r3, #10	@ Mueve el valor 10 a r3
	str	r3, [r7, #8]	@ Guarda el valor de r3 en la dirección de memoria
	ldr	r1, [r7, #8]	@ Recupera el valor guardado anteriormente (10) en esa dirección de memoria
	ldr	r0, [r7, #12]	@ Recupera el valor guardado anteriormente (5) en esa dirección de memoria
	bl	suma
	str	r0, [r7, #4]	@ Guarda el resultado en memoria
	movs	r3, #0
	mov	r0, r3
	adds	r7, r7, #16
	mov	sp, r7
	@ sp needed
	pop	{r7, pc}
	.size	main, .-main
	.ident	"GCC: (Arm GNU Toolchain 12.2.Rel1 (Build arm-12.24)) 12.2.1 20221205"
