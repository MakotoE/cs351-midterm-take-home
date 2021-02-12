build:
	as -ggdb -o numarray.o numarray.s
	gcc -ggdb -o numarray numarray.o

clean:
	rm -f numarray.o numarray