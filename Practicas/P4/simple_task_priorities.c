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
//#include "timers.h"
//#include "semphr.h"

/* Local includes. */
#include "console.h"

#define PRIORITY1    ( tskIDLE_PRIORITY + 2 )
#define PRIORITY2       ( tskIDLE_PRIORITY + 1 )

int DELAY_LOOP_COUNT=1000000000;

static void vASimpleTask( void * pvParameters ){
	int delay;
	const TickType_t xDelay = delay / portTICK_PERIOD_MS;
	for(;;)
	{
		console_print( "Tarefa %s\n",pcTaskGetName(NULL));
		for(delay=0;delay < DELAY_LOOP_COUNT; delay++ ){}
	}
}

void main_blinky( void )
{
		TaskHandle_t xHandle1 = NULL;
		TaskHandle_t xHandle2 = NULL;
		xTaskCreate( vASimpleTask,             
                     "S1",                            
                     configMINIMAL_STACK_SIZE, 
                     NULL, 
                     PRIORITY1,
                     &xHandle1); 

        xTaskCreate( vASimpleTask, "S2", configMINIMAL_STACK_SIZE, NULL, PRIORITY1, &xHandle2);

        vTaskStartScheduler();

    for( ; ; )
    {
    }
}
