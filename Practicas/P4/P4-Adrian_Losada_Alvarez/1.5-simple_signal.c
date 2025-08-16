#include <stdio.h>
#include <signal.h>
#include <unistd.h>

void sig_handler(int signum){		// Manipulador de señales
	printf( "Recibida sinal\n");	// Imprime el mensaje y vuelve al main()
}

int main(){
	signal(SIGUSR1,sig_handler);	// Entra aqui cuando recibe el 'kill' con la señal SIGUSR1
	sleep(20);			// Suspende el hilo durante 20 segundos para ejecutar los comandos en la terminal
}
