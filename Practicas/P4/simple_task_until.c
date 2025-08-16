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
	TickType_t xLastWakeTime = xTaskGetTickCount();
	const TickType_t xDelay = pdMS_TO_TICKS(delay);
	for(;;)
	{
		console_print( "Tarefa %s con retraso %d\n",pcTaskGetName(NULL),delay );
		vTaskDelayUntil(&xLastWakeTime,xDelay);
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