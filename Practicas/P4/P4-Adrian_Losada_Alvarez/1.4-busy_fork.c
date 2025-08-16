#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int variable=5;

// Función para iterar durante un tiempo para poder ver el consumo de la CPU
double traballo_inutil(int reps){
	long int i;
	double res=0;
	for(i=0;i<reps;i++){
		res=res*res*res*res*res;
	}
	return res;
}

int main(){
	// Declara las variables para guardar los PID
	pid_t pid;
	pid_t pid_f;
	pid_t ret;
	int status;
	long int reps=10000000000000000;
	double res;
	
	pid = getpid();
	printf("Son o proceso %u\n", pid);
	
	pid_f = fork();
	
	if(pid_f!=0){	// El padre entra en el if
		printf("Son o proceso pai %u, creei o fillo %u. Variable=%d con direccion %p\n", pid, pid_f,variable,&variable);
		variable= 10;
		printf("Son o proceso pai %u, cambio o valor de variable. Variable=%d con direccion %p\n", pid,variable,&variable);
	}else{		// El hijo entra en el else
		sleep(5);
		pid=getpid();
		int exit_status=68;
		printf("Son o proceso fillo %u, creoume meu pai %u.Variable=%d con direccion %p\n", pid, getppid(),variable,&variable);
		variable = 55;
		res=traballo_inutil(reps);	// Se ejecuta la función para cargar trabajo en el procesador (proceso hijo)
		printf("Son o proceso fillo %u, cambio variable=%d con direccion %p. Saindo con exit status %d\n", pid,variable,&variable, exit_status);
		exit(exit_status);		// Finaliza el proceso hijo con valor exit_status=68
	}
	res=traballo_inutil(reps);		// Se ejecuta la función para cargar trabajo en el procesador (proceso padre)
	ret = wait(&status);			// El proceso padre espera a que termine el proceso hijo y obtiene su 'status' de finalización
	printf("Son o proceso pai %u, o meu %u fillo acabou con saida %d. Variable=%d con direccion %p\n", pid, ret, WEXITSTATUS(status), variable,&variable);
	exit(0);
}
	
