#define _GNU_SOURCE //para que funcione gettid()
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <sys/syscall.h>

//Isto non vos preocupedes moito del
#ifndef SYS_gettid
#error "SYS_gettid unavailable on this system"
#endif

#define gettid() ((pid_t)syscall(SYS_gettid))

void * ola(void *entrada);
int variable=5;

int main(){
	pid_t pid;
	int status;
	pthread_t fio1; //non o mesmo que o TID, identificador propio
	int res;
	
	pid = getpid();	// Guarda el identificador del proceso
	printf("Son o proceso %u\n", pid);
	
	res = pthread_create(&fio1, NULL, ola, "Ola mundo");	// Crea un hilo y devuelve el identificador del hilo. Si se creó el hilo correctamente, pthread_create() devuelve un 0.
	if(res!=0){	// Si pthread_create() no creó el hilo correctamente, entra en este if{}
		printf("Erro creando o fío\n");
		exit(-1);
	}
	printf("Son o proceso %u, creei o fio %lu. Variable=%d con direccion %p\n", pid, fio1,variable,&variable);
	variable= 10;
	printf("Son o proceso pai %u, cambio o valor de variable. Variable=%d con direccion %p\n", pid,variable,&variable);
	pthread_join(fio1,NULL);	// Espera a que el otro hilo termine llamando a esta función
	printf("Son o proceso pai %u, acabou o meu fío %lu. Variable=%d con direccion %p\n", pid,fio1,variable,&variable);	// El último valor de la variable será el que declaró el nuevo hilo
	exit(0);			// Provoca la finalización del proceso
}

void * ola(void *entrada){
	sleep(2);			// Suspende el hilo durante dos segundos para que le dé tiempo al main() a imprimir los dos printf() y a cambiar el valor de 'variable'
    printf("Son o fío con pid %u e tid %u. Variable=%d con direccion %p, %s\n", getpid(), gettid(),variable,&variable,(char *)entrada);
    variable = 78;			// Cambia el valor de la variable
    printf("Son o fío con pid %u e tid %u. Cambio o valor de variable=%d con direccion %p\n", getpid(), gettid(), variable,&variable);	// Se muestran los identificadores de los dos hilos
    pthread_exit(NULL);		// Cuanto termina el trabajo que se le asignó, llama a esta función que suspende el hilo y libera su pila
}
