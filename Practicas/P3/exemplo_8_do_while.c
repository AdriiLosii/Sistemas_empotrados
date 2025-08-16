#include <stdint.h>

int sum = 0;
int i = 10;

int main(){
	do{
		sum += i;
		i--;
	}while( i > 0);
	return 0;
}
	
	