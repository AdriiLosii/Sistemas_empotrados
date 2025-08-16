#include <stdint.h>

int32_t x = 0x00000001;
int32_t a = 32;

int main(){
	if (a < 0){
		a = 0 - a;
	}
	x = x + 1;
	return 0;
}
	
	