gcc -c st1.c st2.c
ar -rsv libmytest.a st1.o st2.o
gcc -o test main.c -L./ -lmytest
