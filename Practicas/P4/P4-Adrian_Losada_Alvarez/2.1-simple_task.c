/*
 * NOTE:  Console input and output relies on Linux system calls, which can
 * interfere with the execution of the FreeRTOS Linux port. This demo only
 * uses Linux system call occasionally. Heavier use of Linux system calls
 * may crash the port.
 */

#include <stdio.h>
#include <pthread.h>

/* Kernel includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "timers.h"
#include "semphr.h"

/* Local includes. */
#include "console.h"

#define PRIORITY1    ( tskIDLE_PRIORITY + 2 )
#define PRIORITY2       ( tskIDLE_PRIORITY + 1 )

// Tarea creada
static void vASimpleTask( void * pvParameters ){
	// Se espera que el valor del parametro sea mayor que 1 ya que se pasa 500 en el valor de pvParameters en la llamada 'xTaskCreate()' a continuacion
	configASSERT( ( *( int *) pvParameters ) > 1 );
	int delay = *(int*) pvParameters;			// Inicializa el valor de delay con valor que le pasa pvParameters
	const TickType_t xDelay = delay / portTICK_PERIOD_MS; // Bloque por valor de delay	
	for(;;)	// El codigo de la tarea va aqui
	{
		// 'pcTaskGetNAme()' busca el nombre de de una tarea desde el identificador de la tarea que se pasa como parametro, si se establece en 'NULL' sirve para consultar el nombre de la tarea que realiza la llamada
		console_print( "Tarefa %s con retraso %d\n",pcTaskGetName(NULL),delay );	// Muestra en la consola
		vTaskDelay(xDelay);	// Aplica el delay especificado
	}
}

void main_blinky( void )	// Función que crea una tarea
{
		// Inicializa los valores de los delays
		int delay1 = 500;
		int delay2 = 1000;
		// Referencia las tareas a NULL
		TaskHandle_t xHandle1 = NULL;
		TaskHandle_t xHandle2 = NULL;

		// Crea la tarea almacenando el identificador
		xTaskCreate( vASimpleTask,	// Función que implementa la tarea
                     "S1",			// Nombre para la tarea
                     configMINIMAL_STACK_SIZE,// Tamaño de la pila en palabra
                     (void *) &delay1,	// Parametro pasado a la tarea
                     PRIORITY1,		// Prioridad con la que se crea la tarea
                     &xHandle1);		// Se utiliza para pasar el identificador de la tarea creada

	// Crea otra tarea
        xTaskCreate( vASimpleTask, "S2", configMINIMAL_STACK_SIZE, (void *) &delay2, PRIORITY2, &xHandle2);

	// Inicia el programa de RTOS en tiempo real, despues de llamar, el kernel de RTOS tiene control sobre que tareas se ejecutan y cuando. Solo regresa si no hay suficiente almacenamiento dinámico RTOS disponible para crear tareas inactivas o del dominio del temporizador
        vTaskStartScheduler();

    for( ; ; )	// Bucle infinito
    {
    }
}
