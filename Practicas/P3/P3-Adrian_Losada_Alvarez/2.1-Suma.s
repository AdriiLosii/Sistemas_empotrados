	.data

V:	.word 2,4,6,3,10,1,4	@ Definimos el vector
suma:	.space 4

	.text

main:	ldr r0, =V


bucle:  cmp r1, #7       	@ Compara la posición actual con la longitud del vector
	beq finbuc       	@ Cuando la posición y el tamaño del bucle sean iguales saltará a la etiqueta finbuc, que finalizará el bucle
	ldr r3, [r0]     	@ Guarda el valor de la posición de memoria de r0 en r3 (el valor de la posición actual del vector)
	cmp r3, #5	 	@ Compara ese valor con 5
	bls cont	 	@ Si ese valor es menor o igual a 5 salta a la dirección de memoria de la etiqueta cont, de no ser así, ejecuta el código siguiente a esta instrucción
	add r2, r2, r3		@ Guarda el valor del sumatorio y el valor del dato del vector en la posición actual (si es mayor que 5)

cont:				@ Si el valor es menor que cinco, salta aquí
	add r1, r1, #1   	@ Aumenta en 1 el valor de la posición
	add r0, r0, #4   	@ Guarda el siguiente valor del vector en r0
	b bucle			@ Vuelve al bucle

finbuc: ldr r0, =suma   	@ Cuando la posición alcanza la longitud del vector saltase aqui
	str r0, [r0]   	        @ Se guarda el valor total de la suma de los valores mayores que 5 en r2

end:	wfi			@ Fin del programa
