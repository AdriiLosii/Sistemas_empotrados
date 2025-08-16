	.data

a:	.word 1
b:	.word 2
c:	.word 3
d:	.word 4
e:	.word 5
f:	.word 6
res1:	.space 4
res2:	.space 4
res3:	.space 4
sumtot:	.space 4


	.text

@	Programa principal	@
main:	ldr r0, =a		@ Pasamos los numeros por valor
	ldr r0, [r0]
	ldr r1, =b
	ldr r1, [r1]
        ldr r2, =c
        ldr r2, [r2] 
	ldr r3, =d
	ldr r3, [r3]
	ldr r4, =e
	ldr r4, [r4]
	ldr r5, =f
	ldr r5, [r5]

	bl opera		@ Llamamos a la primera subrutina

	ldr r6, =sumtot		@ Devuelve el resultadosç y lo guardamos en memoria
	str r0, [r6]

end:   wfi


@	Subrutina 1	@
opera:	push {r4-r7, lr}	@ Guardamos los valores de los registros del r4 al r7 en la pila
	sub sp, sp, #40		@ Reservamos memoria en la pila para las variables que se van a usar
	add r7, sp, #0		@ r7 lo vamos a usar para movernos por la pila en funcion de sp
	@ Guardamos los valores de los registros del r0 al r3 en la pila
	str r0, [sp, #24]
	str r1, [sp, #28]
	str r2, [sp, #32]
	str r3, [sp, #36]

mults:	mov r1, r5
	bl mult			@ Primera llamada a la subrutina de multiplicación (a*f)
	str r2, [r7]		@ Se guarda el resultado obtenido en la dirección de memoria de sp
	add r7, r7, #4		@ Se actualiza r7 con la siguiente dirección de memoria de la pila

	ldr r2, [sp, #32]	@ Se recupera el valor de r2 orignal para hacer la segunda multiplicacion
	@ Copiamos los valores que le queremos pasar a la multiplicacion en r0 y r1
	mov r0, r2
	mov r1, r3

	bl mult			@ Segunda llamada a la segunda subrutina (c*d)
	str r2, [r7]
	add r7, r7, #4

	ldr r1, [sp, #28]	@ Se recupera el valor de r1 orignal para hacer la segunda multiplicacion
	mov r0, r3		@ Copiamos el valor que le queremos pasar a la mutiplicación en r0 (como vuelve a ser *d no necesitamos copiarlo también, ya lo tenemos de antes)

	bl mult			@ Tercera llamada a la segunda subrutina (b*d)
	str r2, [r7]
	add r7, r7, #4

suma:	ldr r0, [sp, #0]	@ Sumamos por separado los resultados obtenidos de las tres multiplicaciones
	ldr r1, [sp, #4]
	add r2, r0, r1

	ldr r3, [sp, #8]
	add r2, r2, r3		@ La suma total se guarda en r2
	str r2, [r7]		@ La guardamos en memoria, en la dirección de sp que nos indica r7

	add sp, sp, #40		@ Liberamos el espacio de las variables locales
	pop {r4-r7, pc}		@ Restauramos el valor original de los registros y del pc

@	Multiplicacion		@
mult:	push {lr}		@ Guardamos en la pila la dirección de retorno
	mov r2, #0		@ Lo inicializamos a cero para guardar luego el resultado de la multiplicación

for:	cmp r1, #0		@ Comparamos el indice con 0 (bucle for)
	beq finmul		@ Si es indice es 0, se termina la multiplicación (suma)
	add r2, r2, r0		@ Si no es así, se suma al sumador el número 
	sub r1, r1, #1		@ Se resta 1 al indice
	b for			@ Se llama a la etiqueta recursivamente

finmul:	pop {pc}		@ Copiamos la dirección de retorno en el contador de programa antes de regresar
