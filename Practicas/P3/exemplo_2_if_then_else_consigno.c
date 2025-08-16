#include <stdint.h>

int32_t x = 0x00000001;
int32_t y = 0xFFFFFFFF;
int32_t z;

int main(){
	if (x > y)
		z = 1;
	else
		z = 0;
	return 0;
}
	
	