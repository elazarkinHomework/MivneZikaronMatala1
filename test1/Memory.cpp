#include <stdlib.h>
#include <stdio.h>

void test()
{
	char *mem = (char *) malloc(1024);
}

int main(int argsAmount, const char **args) 
{
	int DEFAULT_SIZE = 100;
	int size = argsAmount > 1 ? atoi(args[1]):DEFAULT_SIZE;

	size = size <= 0 ? DEFAULT_SIZE:size;

	printf("start...\n");
	for(int i = 0; i < size; i++)
	{
		test();
	}
	printf("end...\n");
}
