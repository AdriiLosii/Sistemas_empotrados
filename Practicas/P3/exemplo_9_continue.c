#include <stdint.h>

int i;
int sum = 0;

int main(){
	for( i=0; i<10; i++){
		if(i==5) continue;
		sum += i;
	}
	return 0;
}
	
	