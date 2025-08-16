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


TaskHandle_t xHandleStopResume;

static void vASimpleTask( void * pvParameters ){
	configASSERT( ( *( int *) pvParameters ) > 1 );
	int delay = *(int*) pvParameters;
	const TickType_t xDelay = delay / portTICK_PERIOD_MS;
	for(;;)
	{
		console_print( "Tarefa %s con retraso %d\n",pcTaskGetName(NULL),delay );
		vTaskDelay(xDelay);
	}
}

static void vStopResume( void * pvParameters ){
	configASSERT( ( *( int *) pvParameters ) > 1 );
	int delay = *(int*) pvParameters;
	const TickType_t xDelay = delay / portTICK_PERIOD_MS;
	for(;;)
	{
		vTaskDelay(xDelay);
		console_print( "Reanudando %s\n",pcTaskGetName(xHandleStopResume));
		vTaskResume(xHandleStopResume);
		vTaskDelay(xDelay);
		console_print( "Parando %s\n",pcTaskGetName(xHandleStopResume));
		vTaskSuspend(xHandleStopResume);
	}
}

void main_blinky( void )
{
		int delay1 = 500;
		int delay2 = 1000;
		int delay3 = 5000;
		TaskHandle_t xHandle1 = NULL;
		TaskHandle_t xHandle2 = NULL;
		xTaskCreate( vASimpleTask,             
                     "S1",                            
                     configMINIMAL_STACK_SIZE, 
                     (void *) &delay1, 
                     PRIORITY1,
                     &xHandle1); 
		
        xHandleStopResume = xHandle1;

        xTaskCreate( vASimpleTask, "S2", configMINIMAL_STACK_SIZE, (void *) &delay2, PRIORITY2, &xHandle2);
        xTaskCreate( vStopResume, "Stopper", configMINIMAL_STACK_SIZE, (void *) &delay3, PRIORITY2, NULL);

        vTaskStartScheduler();

    for( ; ; )
    {
    }
}