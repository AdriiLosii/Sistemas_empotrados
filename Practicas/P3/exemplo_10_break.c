#include <stdint.h>

char str[] = "hello";
int len = 0;
char *p = str; //igualamos o punteiro ao comezo da cadea


int main(){
	for( ; ;){
		if(*p== '\0') //se derradeira letra é o caracter \0 indica o final da cadea de caracteres
			break;
		p++; //aumentamos o punteiro, ou sexa, apuntamos a seguinte letra
		len++; //imos contando as letras
	}
	return 0;
}
	
	