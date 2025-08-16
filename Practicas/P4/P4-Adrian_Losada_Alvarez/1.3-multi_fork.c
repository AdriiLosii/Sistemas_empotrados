#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int variable=5;

void funcionFillo(int i){
	pid_t pid;
	sleep(i);		// Suspende la función durante 'i' segundos
	pid=getpid();
	int exit_status=i+7;	// Define el estado de salida del hijo dependiento de 'i'
	printf("Son o proceso fillo %u, creoume meu pai %u.Variable=%d con direccion %p\n", pid, getppid(),variable,&variable);
	variable = i*5;	// A partir de cada hijo (valor de 'i'), se obtiene un valor de variable distinto
	printf("Son o proceso fillo %u, cambio variable=%d con direccion %p. Saindo con exit status %d\n", pid,variable,&variable, exit_status);
	exit(exit_status);	// Devuelve el estado de salida y finaliza el proceso hijo
}

int main(){
	// Se declaran las variables
	pid_t pid;
	pid_t pid_f[4];		// Número de hijos
	pid_t ret=0;
	int status,i;
	
	pid = getpid();
	printf("Son o proceso %u\n", pid);
	for(i=2;i<6;i++){		// Ejecua el bucle 4 veces
		pid_f[i-2] = fork();	// Crea 4 hijos
		if(pid_f[i-2]==0){	// Los 4 hijos entran en el if()
			funcionFillo(i);// Envia a funcionFillo() el valor de 'i'
		}else{			// El padre entra 4 veces en el else (ya que se han creado 4 hijos)
			printf("Son o proceso pai %u, creei o fillo %u. Variable=%d con direccion %p\n", pid, pid_f[i-2],variable,&variable);
			variable= i*10;	// Cada vez que entra el padre, el valor se actualiza
			printf("Son o proceso pai %u, cambio o valor de variable. Variable=%d con direccion %p\n", pid,variable,&variable);
		}
	}

	//Para quitar
	//ret = wait(&status);
	//printf("Son o proceso pai %u, o meu %u fillo acabou con saida %d. Variable=%d con direccion %p\n", pid, ret, WEXITSTATUS(status), variable,&variable);
	//exit(0);
	//Para quitar

	// Mientras no terminen los hijos, va a estar esperando
	while(ret>=0){
		ret = wait(&status);
		printf("Son o proceso pai %u, o meu %u fillo acabou con saida %d. Variable=%d con direccion %p\n", pid, ret, WEXITSTATUS(status), variable,&variable);
	}
	printf("Son o proceso pai %u, non quedan mais fillo porque ret=%d\n", pid,ret);
	exit(0);
	
}
	
