	@ Instrucciones para el ensamblador (inician con un ".")
	.cpu cortex-m0		@ tipo de cpu
	.arch armv6s-m		@ conjunto de instrucciones para el cual se debe compilar este código
	.fpu softvfp		@ especifica la unidad de punto flotante que se utilizará
	@ atributos que declaran al ensamblador varias opciones que estan presentes o ausentes en la CPU:
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"suma_1-2.c"	@ nombre del archivo
	.text			@ indica que inicia una región de programa que necesitará ser ensamblada
	.bss			@ en esta sección se definen las variables del programa
	.align	2		@ declara la alineación requerida (en este caso, align 2 significa alinear con el siguiente límite de 4 bytes)
c:				@ se define la variable c:
	.space	4		@ reserva una dirección de memoria de espacio 4 bytes
	.size	c, 4		@ tamaño de la variable c
	.text			@ ya comentado
	.align	1		@ ya comentado
	.syntax unified	@ establece la sintaxis del conjunto de instrucciones
	.code	16		@ selecciona el conjunto de instrucciones que se genera, el valor 16 selecciona Thumb
	.thumb_func		@ señala el inicio de una función de tipo Thumb
	.type	main, %function	@ se define el nombre y el tipo
main:				@ se define la función main()
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L3	@ prepara la dirección (carga la dirección de L3 en r3)
	movs	r2, #12	@ podemos observar el resultado de 7+5, que se está asignando al registro 2
	str	r2, [r3]	@ guarda el contenido de r2 en la memoria
	movs	r3, #0		@ mueve el valor 0 al registro 3
	movs	r0, r3		@ mueve el registro 3 al registro 0
	@ sp needed
	bx	lr		@ salto a subrutina (branch and link)
.L4:
	.align	2		@ ya comentado
.L3:
	.word	c		@ carga de la memoria la variable c
	.size	main, .-main	@ tamaño de main: dirección actual - dirección de main
	.ident	"GCC: (Arm GNU Toolchain 12.2.Rel1 (Build arm-12.24)) 12.2.1 20221205"	@ firma del compilador
