	.data

V:	.word 2,4,6,3,10,1,4	@ Definimos el vector
len:	.word 7			@ Variable que define el tamaño del vector
num:	.word 5			@ Número a comparar
suma:	.space 4

	.text

main:	ldr r4, =len
	ldr r5, =num

	ldr r0, =V		@ Pasamos por referencia
	ldr r1, [r4]		@ Pasamos por valor
	ldr r2, [r5]		@ Pasamos por valor
	mov r4, #0

	bl sum
	ldr r7, =suma
	str r0, [r7]		@ Devuelve el resultado y lo guarda en memoria

end:	wfi			@ Fin del programa

@	Subrutina	@
sum:	cmp r4, r1		@ Compara 7 (longitud del vector) con la longitud actual
	beq finbuc		@ Si son iguales, finaliza el bucle, de lo contrario, continúa

	ldr r6, [r0]		@ Obtenemos el valor correspondiente del vector
	cmp r6, r2		@ Comparamos ese valor con el número a comparar (5)
	bls cont		@ Si es menor o igual al número a comparar, salta a la etiqueta cont
	add r3, r3, r6		@ De no ser así, guarda el valor del sumatorio y el valor del dato del vector en la posición actual (si es mayor que 5)

cont:	add r4, r4, #1		@ Aumenta en 1 el valor de la posición
	add r0, r0, #4   	@ Guarda el siguiente valor del vector en r0
	b sum			@ Vuelve al bucle

finbuc: mov pc, lr
