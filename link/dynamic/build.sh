#!/bin/bash

#gcc -c -fPIC test_a.c test_b.c test_c.c
#gcc -shared -fPIC -o libtest.so test_a.o test_b.o test_c.o
gcc -shared -fPIC -o libtest.so test_a.c test_b.c test_c.c

gcc -Wall -L. -o test main.c -ltest

# execute
export LD_LIBRARY_PATH=`pwd`:$LD_LIBRARY_PATH 
./test
