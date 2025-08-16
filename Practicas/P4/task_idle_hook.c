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

volatile uint32_t ulIdleCycleCount = 0UL;

static void vTaskPrintCount( void * pvParameters ){
	configASSERT( ( *( int *) pvParameters ) > 1 );
	int delay = *(int*) pvParameters;
	const TickType_t xDelay = delay / portTICK_PERIOD_MS;
	for(;;)
	{
		console_print( "Tarefa %s con retraso %d. Contador %u\n",pcTaskGetName(NULL),delay,ulIdleCycleCount);
		vTaskDelay(xDelay);
	}
}

//Nome obligatoria para o o Hook a Idle Task, non pode coller parámetros
void vApplicationIdleHook( void )
{
    ulIdleCycleCount++;
}

void main_blinky( void )
{
		int delay1 = 500;
		int delay2 = 1000;
		TaskHandle_t xHandle1 = NULL;
		TaskHandle_t xHandle2 = NULL;
		xTaskCreate( vTaskPrintCount,             
                     "S1",                            
                     configMINIMAL_STACK_SIZE, 
                     (void *) &delay1, 
                     PRIORITY1,
                     &xHandle1); 

        xTaskCreate( vTaskPrintCount, "S2", configMINIMAL_STACK_SIZE, (void *) &delay2, PRIORITY2, &xHandle2);

        vTaskStartScheduler();

    for( ; ; )
    {
    }
}