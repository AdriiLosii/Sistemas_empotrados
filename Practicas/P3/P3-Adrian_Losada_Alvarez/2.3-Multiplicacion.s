	.data

a:    .word 3
b:    .word 4
res: .space 4

	.text

main:	ldr r0, =a	@ Cargamos los números y los almacenamos en memoria
	ldr r0, [r0]
	ldr r1, =b
  	ldr r1, [r1]

mult:	cmp r2, r1	@ Compara el contador con el segundo número
	beq finbuc	@ Si estos son iguales, se finaliza el bucle (multiplicación realizada)
	add r3, r3, r0	@ Si no es así, se suma el número al sumatorio

	add r2, r2, #1	@ Aumenta en 1 el contador
	b mult 		@ Vuelve a saltar a la etiqueta (seguir sumando si procede)

finbuc:	ldr r2, =res
	str r0, [r2]	@ Se almacena el resultado en memoria

end:	wfi
