#include <stdint.h>

uint32_t x = 0x00000001;
uint32_t y = 0xFFFFFFFF;
uint32_t z;

int main(){
	if (x > y)
		z = 1;
	else
		z = 0;
	return 0;
}
	
	