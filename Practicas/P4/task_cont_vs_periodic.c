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

static void vPeriodicTask( void * pvParameters ){
	configASSERT( ( *( int *) pvParameters ) > 1 );
	int delay = *(int*) pvParameters;
	TickType_t xLastWakeTime = xTaskGetTickCount();
	const TickType_t xDelay = pdMS_TO_TICKS(delay);
	for(;;)
	{
		console_print( "Tarefa periódica %s con retraso %d\n",pcTaskGetName(NULL),delay );
		vTaskDelayUntil(&xLastWakeTime,xDelay);
	}
}

static void vContinuousTask( void * pvParameters ){
	char *pcTaskName;
	pcTaskName = (char *) pvParameters;
	for(;;)
	{
		console_print( "Tarefa continua %s\n",pcTaskName);
	}
}

void main_blinky( void )
{
		int delay1 = 3;
		int delay2 = 1000;
		TaskHandle_t xHandle1 = NULL;
		TaskHandle_t xHandle2 = NULL;
		xTaskCreate( vPeriodicTask,             
                     "P1",                            
                     configMINIMAL_STACK_SIZE, 
                     (void *) &delay1, 
                     PRIORITY1,
                     &xHandle1); 

        xTaskCreate( vContinuousTask, "C1", configMINIMAL_STACK_SIZE, (void *) "C1", PRIORITY2, &xHandle2);
        xTaskCreate( vContinuousTask, "C2", configMINIMAL_STACK_SIZE, (void *) "C2", PRIORITY2, NULL);

        vTaskStartScheduler();

    for( ; ; )
    {
    }
}