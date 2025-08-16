#include <stdint.h>

int32_t x = 0x00000001;
int32_t a = 32;

int main(){
	if (x > 20 && x < 25){
		a = 1;
	}
	return 0;
}