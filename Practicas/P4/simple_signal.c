#include <stdio.h>
#include <signal.h>
#include <unistd.h>

void sig_handler(int signum){
	printf( "Recibida sinal\n");
}

int main(){
	signal(SIGUSR1,sig_handler);
	sleep(20);
}