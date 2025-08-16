#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int variable=5;

int main(){
	// Variables para guardar los PID
	pid_t pid;
	pid_t pid_f;
	pid_t ret;
	int status;
	
	pid = getpid();		// Obtiene el PID del proceso actual, hasta aqui solo hay un proceso
	printf("Son o proceso %u\n", pid);
	
	pid_f = fork();		// Crea un proceso hijo, que es copia del proceso padre. Aqui hay 2 procesos: un proceso hijo con pid=0 y un padre con pid do proceso creado
	
	if(pid_f!=0){			// La ejecución de la llamada al sistema fork devuelve el identificador al proceso padre. El padre entra en el if{}
		printf("Son o proceso pai %u, creei o fillo %u. Variable=%d con direccion %p\n", pid, pid_f,variable,&variable);
		variable= 10;		// El proceso padre cambia el valor de la variable
		printf("Son o proceso pai %u, cambio o valor de variable. Variable=%d con direccion %p\n", pid,variable,&variable);
	}else{				// La ejecución de la llamada al sistema fork devuelve un 0 al proceso hijo. El hijo entra en el else{}
		sleep(3);
		pid=getpid();		// Obtiene el PID del proceso hijo
		int exit_status=68;	// Declara el valor de salida.
		printf("Son o proceso fillo %u, creoume meu pai %u.Variable=%d con direccion %p\n", pid, getppid(),variable,&variable);	// En este punto la variable tiene el valor de cuando se hizo la copia en la línea 19 (variable=5)
		variable = 55;		// El proceso hijo le cambia el valor a la variable (de la dirección de memoria de la copia)
		printf("Son o proceso fillo %u, cambio variable=%d con direccion %p. Saindo con exit status %d\n", pid,variable,&variable, exit_status);
		exit(exit_status);
	}
	ret = wait(&status);		// Suspende el programa actual hasta que el proceso hijo devuelva el valor del exit(exit_status) al proceso padre.
	printf("Son o proceso pai %u, o meu %u fillo acabou con saida %d. Variable=%d con direccion %p\n", pid, ret, WEXITSTATUS(status), variable,&variable);	// La variable tendrá el valor que le dió el padre
	exit(0);
}
	
