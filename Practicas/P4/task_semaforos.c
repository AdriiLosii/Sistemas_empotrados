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
#define PRIORITY2    ( tskIDLE_PRIORITY + 1 )

// Settings
#define BUF_SIZE 5
#define NUM_PROD_TASKS 5	// Numero de tarefas produtoras
#define NUM_CONS_TASKS 3	// Numero de tarefas consumidoras
#define NUM_ESCRITURAS 3

// Globals
static int buf[BUF_SIZE];             	// Buffer compartido
static int cabeza = 0;               	// Indice para escribir no buffer
static int cola = 0;                  	// Indice para ler do buffer
static SemaphoreHandle_t mutex;       	// COMENTAR
static SemaphoreHandle_t sem_baleiro;  	// COMENTAR
static SemaphoreHandle_t sem_cheo;  	// COMENTAR
static int values[NUM_PROD_TASKS];

//*****************************************************************************
// Tasks

// Produtor: escribir uno buffer compartido
void produtor(void *parameters) {

  // COMENTAR
  int num = *(int *)parameters;

  // COMENTAR
  for (int i = 0; i < NUM_ESCRITURAS; i++) {

    // COMENTAR
    xSemaphoreTake(sem_baleiro, portMAX_DELAY);

    // COMENTAR
    xSemaphoreTake(mutex, portMAX_DELAY);
    buf[cabeza] = num;
    printf("Tarefa %s escribiu %d en %d\n",pcTaskGetName(NULL),num,cabeza);
    cabeza = (cabeza + 1) % BUF_SIZE;
    xSemaphoreGive(mutex);

    // COMENTAR
    xSemaphoreGive(sem_cheo);
    
    //vTaskDelay(1000 / portTICK_PERIOD_MS);
  }

  vTaskDelete(NULL);
}

// Consumidor: ler continuamente do buffer compartido
void consumidor(void *parameters) {

  int val;

  // Ler do buffer
  while (1) {

    // COMENTAR
    xSemaphoreTake(sem_cheo, portMAX_DELAY);

    // COMENTAR
    xSemaphoreTake(mutex, portMAX_DELAY);
    val = buf[cola];
    printf("Tarefa %s leu %d de %d\n", pcTaskGetName(NULL), val, cola);
    cola = (cola + 1) % BUF_SIZE;
    xSemaphoreGive(mutex);

    // COMENTAR
    xSemaphoreGive(sem_baleiro);
    
    //vTaskDelay(1000 / portTICK_PERIOD_MS);
  }
}

void main_blinky( void )
{
		
	char task_name[configMAX_TASK_NAME_LEN];

	  // Create mutexes and semaphores before starting tasks
	  mutex = xSemaphoreCreateMutex();
	  sem_baleiro = xSemaphoreCreateCounting(BUF_SIZE, BUF_SIZE);
	  sem_cheo = xSemaphoreCreateCounting(BUF_SIZE, 0);

	  printf("Semáforos creados\n");
	  // Crear produtores
	  for (int i = 0; i < NUM_PROD_TASKS; i++) {
		sprintf(task_name, "Produtor %i", i);
		values[i] = i; //para pasar o parámetro, como non se inicia todavía o task, e se pasa por referencia, cando se inicien toman todos o valor final de i. O podes probar.
		xTaskCreate(produtor,
					task_name,
					configMINIMAL_STACK_SIZE,
					(void *)&(values[i]),
					PRIORITY1,
					NULL);
	  }

	  // Crear consumidores
	  for (int i = 0; i < NUM_CONS_TASKS; i++) {
		sprintf(task_name, "Consumi. %i", i);
		xTaskCreate(consumidor,
					task_name,
					configMINIMAL_STACK_SIZE,
					NULL,
					PRIORITY1,
					NULL);
	  }
	  // Avisar de que todo creado
	  xSemaphoreTake(mutex, portMAX_DELAY);
	  printf("Todas as tarefas creadas\n");
	  xSemaphoreGive(mutex);

	  vTaskStartScheduler();
  	
    for( ; ; )
    {
    	// Non facer nada
    	vTaskDelay(1000 / portTICK_PERIOD_MS);
    }
}