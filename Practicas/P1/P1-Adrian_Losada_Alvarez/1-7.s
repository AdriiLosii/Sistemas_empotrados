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
	.eabi_attribute 30, 2
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"suma_1-5.c"	@ nombre del archivo
	.text			@ indica que inicia una región de programa que necesitará ser ensamblada
	.ident	"GCC: (Arm GNU Toolchain 12.2.Rel1 (Build arm-12.24)) 12.2.1 20221205" @ firma del compilador

@ Se puede apreciar una clara optimización con respecto al código compilado con -O0, ocurre lo mismo que en 1.4, la variable 'c' no se utiliza para nada por lo que el compilador la desprecia y no se tiene en cuenta el programa (no hace nada).
