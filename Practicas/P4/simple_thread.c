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
	
	pid = getpid();
	printf("Son o proceso %u\n", pid);
	
	res = pthread_create(&fio1, NULL, ola, "Ola mundo");
	if(res!=0){
		printf("Erro creando o fío\n");
		exit(-1);
	}
	printf("Son o proceso %u, creei o fio %lu. Variable=%d con direccion %p\n", pid, fio1,variable,&variable);
	variable= 10;
	printf("Son o proceso pai %u, cambio o valor de variable. Variable=%d con direccion %p\n", pid,variable,&variable);
	pthread_join(fio1,NULL);
	printf("Son o proceso pai %u, acabou o meu fío %lu. Variable=%d con direccion %p\n", pid,fio1,variable,&variable);
	exit(0);
}

void * ola(void *entrada){
	sleep(2);
    printf("Son o fío con pid %u e tid %u. Variable=%d con direccion %p, %s\n", getpid(), gettid(),variable,&variable,(char *)entrada);
    variable = 78;
    printf("Son o fío con pid %u e tid %u. Cambio o valor de variable=%d con direccion %p\n", getpid(), gettid(), variable,&variable);
    pthread_exit(NULL);
}