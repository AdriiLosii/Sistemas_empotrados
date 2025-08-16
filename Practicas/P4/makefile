CC=gcc
CFLAGS=-O0


simple_fork: simple_fork.c
	$(CC) $(CFLAGS) -o simple_fork simple_fork.c 
	
simple_thread: simple_thread.c
	$(CC) $(CFLAGS) -o simple_thread simple_thread.c -lpthread
	
multi_fork: multi_fork.c
	$(CC) $(CFLAGS) -o multi_fork multi_fork.c 
	
busy_fork: busy_fork.c
	$(CC) $(CFLAGS) -o busy_fork busy_fork.c 
	
simple_signal: simple_signal.c
	$(CC) $(CFLAGS) -o simple_signal simple_signal.c 
	
produtor_consumidor_basico: produtor_basico.c consumidor_basico.c
	$(CC) $(CFLAGS) -o produtor_basico produtor_basico.c -lpthread -lrt
	$(CC) $(CFLAGS) -o consumidor_basico consumidor_basico.c -lpthread -lrt
	
produtor_consumidor_semaforos: produtor_semaforos.c consumidor_semaforos.c
	$(CC) $(CFLAGS) -o produtor_semaforos produtor_semaforos.c -lpthread -lrt
	$(CC) $(CFLAGS) -o consumidor_semaforos consumidor_semaforos.c -lpthread -lrt
	
produtor_consumidor_semaforos_v2: produtor_semaforos_v2.c consumidor_semaforos_v2.c
	$(CC) $(CFLAGS) -o produtor_semaforos_v2 produtor_semaforos_v2.c -lpthread -lrt
	$(CC) $(CFLAGS) -o consumidor_semaforos_v2 consumidor_semaforos_v2.c -lpthread -lrt
	
	
	
#FreeRTOS
BUILD_DIR             := ./build
BUILD_DIR_ABS         := $(abspath $(BUILD_DIR))

FREERTOS_DIR_REL      := FreeRTOS/FreeRTOSv202112.00/FreeRTOS
FREERTOS_DIR          := $(abspath $(FREERTOS_DIR_REL))

FREERTOS_PLUS_DIR_REL := FreeRTOS/FreeRTOSv202112.00/FreeRTOS-Plus
FREERTOS_PLUS_DIR     := $(abspath $(FREERTOS_PLUS_DIR_REL))

KERNEL_DIR            := ${FREERTOS_DIR}/Source

INCLUDE_DIRS          := -I.
INCLUDE_DIRS          := -IFreeRTOS
INCLUDE_DIRS          += -I${KERNEL_DIR}/include
INCLUDE_DIRS          += -I${KERNEL_DIR}/portable/ThirdParty/GCC/Posix
INCLUDE_DIRS          += -I${KERNEL_DIR}/portable/ThirdParty/GCC/Posix/utils
INCLUDE_DIRS          += -I${FREERTOS_DIR}/Demo/Common/include
INCLUDE_DIRS          += -I${FREERTOS_PLUS_DIR}/Source/FreeRTOS-Plus-Trace/Include

#SOURCE_FILES          := $(wildcard *.c)
SOURCE_FILES          += $(wildcard ${FREERTOS_DIR}/Source/*.c)
# Memory manager (use malloc() / free() )
SOURCE_FILES          += ${KERNEL_DIR}/portable/MemMang/heap_3.c
# posix port
SOURCE_FILES          += ${KERNEL_DIR}/portable/ThirdParty/GCC/Posix/utils/wait_for_event.c
SOURCE_FILES          += ${KERNEL_DIR}/portable/ThirdParty/GCC/Posix/port.c



rtos_main_blinky: FreeRTOS/main_blinky.c
	
	$(CC) $(CFLAGS) $(INCLUDE_DIRS) -DprojCOVERAGE_TEST=1 -DUSER_DEMO=0 -o rtos_blinky FreeRTOS/main.c FreeRTOS/main_blinky.c FreeRTOS/console.c $(SOURCE_FILES) -lpthread
	
rtos_simple_task: simple_task.c
	
	$(CC) $(CFLAGS) $(INCLUDE_DIRS)  -DprojCOVERAGE_TEST=1 -o rtos_simple_task simple_task.c FreeRTOS/main.c FreeRTOS/console.c $(SOURCE_FILES) -lpthread
	
rtos_simple_task_stop_resume: simple_task_stop_resume.c
	
	$(CC) $(CFLAGS) $(INCLUDE_DIRS)  -DprojCOVERAGE_TEST=1 -o rtos_simple_task_stop_resume simple_task_stop_resume.c FreeRTOS/main.c FreeRTOS/console.c $(SOURCE_FILES) -lpthread
	
rtos_simple_task_priorities: simple_task_priorities.c
	
	$(CC) $(CFLAGS) $(INCLUDE_DIRS)  -DprojCOVERAGE_TEST=1 -o rtos_simple_task_priorities simple_task_priorities.c FreeRTOS/main.c FreeRTOS/console.c $(SOURCE_FILES) -lpthread
	
rtos_simple_task_until: simple_task_until.c
	
	$(CC) $(CFLAGS) $(INCLUDE_DIRS)  -DprojCOVERAGE_TEST=1 -o rtos_simple_task_until simple_task_until.c FreeRTOS/main.c FreeRTOS/console.c $(SOURCE_FILES) -lpthread
	
rtos_task_cont_vs_periodic: task_cont_vs_periodic.c
	
	$(CC) $(CFLAGS) $(INCLUDE_DIRS)  -DprojCOVERAGE_TEST=1 -o rtos_task_cont_vs_periodic task_cont_vs_periodic.c FreeRTOS/main.c FreeRTOS/console.c $(SOURCE_FILES) -lpthread
	
rtos_task_idle_hook: task_idle_hook.c
	
	$(CC) $(CFLAGS) $(INCLUDE_DIRS)  -DprojCOVERAGE_TEST=1 -o rtos_task_idle_hook task_idle_hook.c FreeRTOS/main_wo_idle_hook.c FreeRTOS/console.c $(SOURCE_FILES) -lpthread
	
rtos_task_semaforos: task_semaforos.c
	
	$(CC) $(CFLAGS) $(INCLUDE_DIRS)  -DprojCOVERAGE_TEST=1 -o rtos_task_semaforos task_semaforos.c FreeRTOS/main.c FreeRTOS/console.c $(SOURCE_FILES) -lpthread