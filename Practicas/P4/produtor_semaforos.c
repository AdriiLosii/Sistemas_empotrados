/////////////////////////////////////////////////////////////
// LIBRERIAS

#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <unistd.h>
#include <sys/mman.h>
#include <signal.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>

//Engadida para semaforos
#include <semaphore.h>

/////////////////////////////////////////////////////////////
// CONSTANTES 

#define N 10
#define TAM_BUFFER (N * sizeof(int))
#define TRUE 1
#define FALSE 0
#define MAX 30

#define NOMBRE_OBXETO_BUFFER "buffer_1"
#define NOMBRE_OBXETO_CONTADOR "contador_1"

/////////////////////////////////////////////////////////////
// SEMAFOROS
sem_t *cheo;
sem_t *candado; //mutex
sem_t *baleiro; 

#define NOMBRE_OBXETO_SEMAFORO_MUTEX "mutex1"
#define NOMBRE_OBXETO_SEMAFORO_CHEO "cheo1"
#define NOMBRE_OBXETO_SEMAFORO_BALEIRO "baleiro1"

/////////////////////////////////////////////////////////////
// VARIABLES GLOBLAIS 

int *buffer; // Punteiro á rexión de memoria compartida
int *contador; // Punteiro á rexión do contador

int fd_contador, fd_buffer; // Descriptores de arquivo dos obxetos anonimos compartidos en memoria, que se crean con shm_open()

/////////////////////////////////////////////////////////////
// FUNCIONS

//Funcións referenciadas pero implementadas máis abaixo
int producirItem(); 	 	//Permite xerar un número aleatorio
void insertarItem(int item); 	//Permite insertar un elemento no buffer
void insertarItemSleep(int item, int s); 	//Permite insertar un elemento no buffer, con sleep no medio
void productor();		//Función principal do productor

//Función main do programa
int main(int argc, char * argv[]) {
	struct stat fd_contador_info;
	
	//Escollemos unha semilla para a xeración de números
	srand(777);

	// Inicializamos os punteros a rexións de memoria a NULL
        buffer = NULL;
        contador=NULL;

         
        //MEMORIA COMPARTIDA

	    //As funcións shm_open() crean un obxeto compartido de memoria, que funciona como unha especie de ficheiro que so esta en memoria principal. É decir, nunca chegara a tranferirse a memoria secundaria. As usamos para compartir variables e rexións de memoria entre os distintos procesos desta aplicacion.
	    fd_contador = shm_open(NOMBRE_OBXETO_CONTADOR, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
	    fd_buffer = shm_open(NOMBRE_OBXETO_BUFFER, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);

    if (fd_buffer==-1 || fd_contador==-1)
    {
        perror("Erro en shm_open()");
        exit(EXIT_FAILURE);
    }

    if (fstat(fd_contador, &fd_contador_info)) // Lemos a informacion sobre fd_contador
    {
        perror("Erro en fstat()");
        exit(EXIT_FAILURE);
    }
    if (fd_contador_info.st_size == 0) // Se fd_contador non ten tamano, é que o estamos creando neste proceso. O resto de obxetos tamen seran creados.
    {
        if (ftruncate(fd_contador, sizeof(int)) == -1) // Se o obxeto orixinalmente non tiña o tamano para albergar un int, ponemoslle nos ese tamano. De forma automatica, escribese un 0.
        {
            perror("Erro en ftruncate() para fd_contador");
            exit(EXIT_FAILURE);
        }
        if (ftruncate(fd_buffer, sizeof(int) * TAM_BUFFER) == -1)
        {
            perror("Erro en ftruncate() para fd_buffer");
            exit(EXIT_FAILURE);
        }
    }

    // Mapeamos a memoria compartida entre os procesos
    contador = (int *)mmap(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, fd_contador, 0);
    buffer = (int *)mmap(NULL, sizeof(int) * TAM_BUFFER, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, fd_buffer, 0);
	
	
	
	//Inicializamos o buffer completo todo a -1 en lugar de a 0
	//Desta maneira é máis sinxelo ver os erros
	for(int i=0;i<N;i++)
		buffer[i]=-1;
	
	
	//////////////////////
	//SEMÁFOROS
	//////////////////////
	
	//Xeramos os semaforos. O_CREAT non ten efecto se o semaforo xa estaba creado.
    candado = sem_open(NOMBRE_OBXETO_SEMAFORO_MUTEX, 0); //este ñe o mutex
    // Se a funcion falla, é porque os semaforos non estan creados, asi que os creamos
    if (candado == SEM_FAILED)
    {
        candado = sem_open(NOMBRE_OBXETO_SEMAFORO_MUTEX, O_CREAT | O_EXCL, S_IRUSR | S_IWUSR, 1); // Usamos O_CREAT | O_EXCL porque podería haber dous procesos que detectaran que os semaforos non existen ao mesmo tiempo. Desta forma, so un deles os creara e o outro sairá con codigo de erro
        baleiro = sem_open(NOMBRE_OBXETO_SEMAFORO_BALEIRO, O_CREAT | O_EXCL, S_IRUSR | S_IWUSR, N); //este se inicializa ao tamaño de buffer
        cheo = sem_open(NOMBRE_OBXETO_SEMAFORO_CHEO, O_CREAT | O_EXCL, S_IRUSR | S_IWUSR, 0);
        printf("Semaforos creados.\n");
    }
    else
    {
        // Abrimos o resto de semaforos normalmente, xa que estaban creados de antes
        baleiro = sem_open(NOMBRE_OBXETO_SEMAFORO_BALEIRO, 0);
        cheo = sem_open(NOMBRE_OBXETO_SEMAFORO_CHEO, 0);
        printf("Semaforos abertos.\n");
    }
    
    if (candado == SEM_FAILED || baleiro == SEM_FAILED || cheo == SEM_FAILED)
    {
        perror("Erro en sem_open()");
        exit(EXIT_FAILURE);
    }
	
    ////////////////////////
	//PRODUCTOR
    ////////////////////////
        
	//Chamamos ao productor
	productor();
	
    ////////////////////////
    //Finalizamos o programa
    	
    if (munmap(buffer, sizeof(int) * TAM_BUFFER)) // Desfacemos os mapeos de memoria
    {
        perror("Erro en munmap()");
        // Non salimos con EXIT_FAILURE, xa que nos compensa seguir intentando desmapear o resto de memoria
    }
    if (munmap(contador, sizeof(int)))
    {
        perror("Erro en munmap()");
    }

    if (shm_unlink(NOMBRE_OBXETO_CONTADOR)) // Non se eliminara o obxeto ata que todos os procesos o pechen
    {
        perror("Erro en shm_unlink() ou o obxecto xa foi eliminado");
    }
    if (shm_unlink(NOMBRE_OBXETO_BUFFER))
    {
        perror("Erro en shm_unlink() ou o obxecto xa foi eliminado");
    }
        if (sem_unlink(NOMBRE_OBXETO_SEMAFORO_BALEIRO))
    {
       perror("Erro en sem_unlink() ou o obxecto xa foi eliminado");
    }
    if (sem_unlink(NOMBRE_OBXETO_SEMAFORO_CHEO))
    {
       perror("Erro en sem_unlink() ou o obxecto xa foi eliminado");
    }
    if (sem_unlink(NOMBRE_OBXETO_SEMAFORO_MUTEX))
    {
       perror("Erro en sem_unlink() ou o obxecto xa foi eliminado");
    }
   printf("Semaforos desvinculados.\n");
	
    if (sem_close(baleiro))
    {
        perror("Erro en sem_close");
    }
    if (sem_close(cheo))
    {
        perror("Erro en sem_close");
    }
    if (sem_close(candado))
    {
        perror("Erro en sem_close");
    }
	
	printf("Memoria liberada\nFin da execución\n");
	//Saimos con éxito
	return EXIT_SUCCESS;
}

//////////////////////////////////////
//FUNCIÓNS EXCLUSIVAS DO PRODUCTOR

//Función propia do productor. Permite xerar un número aleatorio e introducirlo no búfer.
//Desde ela chamase ao resto de funcións
void productor(){
	//Imprimimos o nome e o PID do proceso
	printf("\n\n - Comenzamos a produción %d - \n\n", getpid());
	//Declaramos as variables locais
	int item;	//O item a introducir no buffer
	int ran;	//O número aleatorio de segundos que debe esperar
	//Bucle finito
	for(int i=0;i<MAX;i++){
		ran = rand() % 5;   //Xeramos un número aleatorio: 0, 1, 3 o 4.
		//sleep(ran); //Facemos que vaian a diferentes velocidades
		item = producirItem();	//Xerase o elemento
		item=i;
		sem_wait(baleiro);
		sem_wait(candado);
		//insertarItemSleep(item,ran); //Metemos outro elemento no buffer
		insertarItem(item); //Metemos outro elemento no buffer
		sem_post(candado);
		sem_post(cheo);
	}
	printf("O productor terminou!\n");
}


//Función que produce un nuevo elemento
int producirItem(){
	//Xera un número aleatorio de 0 a 100.
	int item = rand() % 100;
	//Regresao
	return item;	
}

//Inserta un elemento dado no buffer
void insertarItem(int item){
	//Accedemos á primeira posición do buffer libre (dada polo contador)
	//e insertamos o elemento
	int pos;
    pos=*contador;
    buffer[pos]=item;
	//Imprimimos o resultado
	printf("\t - Elemento %d gardado en %d\n", item, pos);
	(*contador)+=1;
}

//Inserta un elemento dado no buffer
void insertarItemSleep(int item, int s){
	//Accedemos á primeira posición do buffer libre (dada polo contador)
	//e insertamos o elemento
	int pos;
    pos=*contador;
    sleep(s%3);
	buffer[pos]=item;
	//Imprimimos o resultado
	printf("\t - Elemento %d gardado en %d\n", item, pos);
	(*contador)+=1;
}
