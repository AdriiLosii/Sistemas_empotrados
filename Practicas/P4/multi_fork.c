#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int variable=5;

void funcionFillo(int i){
	pid_t pid;
	sleep(i);
	pid=getpid();
	int exit_status=i+7;
	printf("Son o proceso fillo %u, creoume meu pai %u.Variable=%d con direccion %p\n", pid, getppid(),variable,&variable);
	variable = i*5;
	printf("Son o proceso fillo %u, cambio variable=%d con direccion %p. Saindo con exit status %d\n", pid,variable,&variable, exit_status);
	exit(exit_status);
}

int main(){
	pid_t pid;
	pid_t pid_f[4];
	pid_t ret=0;
	int status,i;
	
	pid = getpid();
	printf("Son o proceso %u\n", pid);
	for(i=2;i<6;i++){
		pid_f[i-2] = fork();
		if(pid_f[i-2]==0){
			funcionFillo(i);
		}else{
			printf("Son o proceso pai %u, creei o fillo %u. Variable=%d con direccion %p\n", pid, pid_f[i-2],variable,&variable);
			variable= i*10;
			printf("Son o proceso pai %u, cambio o valor de variable. Variable=%d con direccion %p\n", pid,variable,&variable);
		}
	}

	//Para quitar
	ret = wait(&status);
	printf("Son o proceso pai %u, o meu %u fillo acabou con saida %d. Variable=%d con direccion %p\n", pid, ret, WEXITSTATUS(status), variable,&variable);
	exit(0);
	//Para quitar
	
	while(ret>=0){
		ret = wait(&status);
		printf("Son o proceso pai %u, o meu %u fillo acabou con saida %d. Variable=%d con direccion %p\n", pid, ret, WEXITSTATUS(status), variable,&variable);
	}
	printf("Son o proceso pai %u, non quedan mais fillo porque ret=%d\n", pid,ret);
	exit(0);
	
}
	