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

static void vASimpleTask( void * pvParameters ){
	configASSERT( ( *( int *) pvParameters ) > 1 );
	int delay = *(int*) pvParameters;
	TickType_t xLastWakeTime = xTaskGetTickCount();	// Inicializa la variable 'xLastWakeTime' con la hora actual
	const TickType_t xDelay = pdMS_TO_TICKS(delay);	// 'pdMS_TO_TICKS()' se puede utilizar para calcular el número de ticks de un tiempo especificado en milisegundos con una resolución de un período de tick, en este caso de 'delay'
	for(;;)
	{
		console_print( "Tarefa %s con retraso %d\n",pcTaskGetName(NULL),delay );
		// Espera al proximo ciclo
		vTaskDelayUntil(&xLastWakeTime,xDelay);	// Especifica la hora absoluta en la que se desea desbloquear la tarea, en este caso, la indicada por 'xLastWakeTime' (hora actual) + 'xDelay' (tiempo de ciclo)
		// Aqui realiza la accion
	}
}

void main_blinky( void )
{
		int delay1 = 500;
		int delay2 = 1000;
		TaskHandle_t xHandle1 = NULL;
		TaskHandle_t xHandle2 = NULL;
		xTaskCreate( vASimpleTask,             
                     "S1",                            
                     configMINIMAL_STACK_SIZE, 
                     (void *) &delay1, 
                     PRIORITY1,
                     &xHandle1); 

        xTaskCreate( vASimpleTask, "S2", configMINIMAL_STACK_SIZE, (void *) &delay2, PRIORITY2, &xHandle2);

        vTaskStartScheduler();

    for( ; ; )
    {
    }
}
