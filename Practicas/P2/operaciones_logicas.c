int a=1;
int b=1;
int c;

static int main(){
	c = ~a;	// NOT
	c = a&b;	// AND
	c = a|b;	// OR
	c = a^b;	// XOR
}
