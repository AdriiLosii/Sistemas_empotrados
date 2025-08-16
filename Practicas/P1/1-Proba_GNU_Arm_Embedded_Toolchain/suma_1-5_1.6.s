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
	.file	"suma_1-5.c"	@ nombre del archivo
	.text			@ indica que inicia una región de programa que necesitará ser ensamblada
	.data			@ en esta sección se definen constantes (datos que no se modificarán durante la ejecución del programa)
	.align	2		@ declara la alineación requerida (en este caso, align 2 significa alinear con el siguiente límite de 4 bytes)
	.type	a, %object	@ se define el nombre y el tipo
	.size	a, 4		@ tamaño de la variable a
a:				@ se define la variable a
	.word	7		@ se asigna e inicializa espacio para la variable con el valor 7
	.align	2		@ ya comentado
	.type	b, %object	@ ya comentado, pero para la variable b
	.size	b, 4		@ ya comentado, pero para la variable b
b:				@ se define la variable b
	.word	5		@ ya comentado, pero para b y con el valor 5
	.bss			@ en esta sección se definen las variables del programa
	.align	2		@ ya comentado
c:				@ se define la variable c
	.space	4		@ reserva una dirección de memoria de espacio 4 bytes
	.size	c, 4		@ ya comentado, pero para la variable c
	.text			@ indica que inicia una región de programa que necesitará ser ensamblada
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
	ldr	r2, [r3]	@ carga r3 en r2 (r3 tiene la dirección de L3)
	ldr	r3, .L3+4	@ prepara la dirección (se aumenta en 4 la dirección de L3 y se carga en r3)
	ldr	r3, [r3]	@ carga r3 en r3 (r3 tiene la dirección de L3+4)
	adds	r2, r2, r3	@ se suman los registros 2 y 3 y se almacena el resultado en el registro 2
	ldr	r3, .L3+8	@ prepara la dirección (se aumenta en 8 la dirección de L3 y se carga en r3)
	str	r2, [r3]	@ guarda el contenido de r2 en la memoria
	movs	r3, #0		@ mueve el valor 0 al registro 3
	movs	r0, r3		@ mueve el registro 3 al registro 0
	@ sp needed
	bx	lr		@ salto a subrutina (branch and link)
.L4:
	.align	2		@ ya comentado
.L3:
	.word	a		@ carga de la memoria la variable a
	.word	b		@ carga de la memoria la variable b
	.word	c		@ carga de la memoria la variable c
	.size	main, .-main	@ tamaño de main: dirección actual - dirección de main
	.ident	"GCC: (Arm GNU Toolchain 12.2.Rel1 (Build arm-12.24)) 12.2.1 20221205" @ firma del compilador

@ No se observa nada que sea 7+5 directamente, ya que en este caso, la suma se está realizando dándole valores a las variables y a continuación sumándolas.
