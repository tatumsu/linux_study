#include <dlfcn.h>
#include <stdlib.h>
#include "my_so_test.h"

void (*fn)();

int main() {
	void *handle = dlopen("./libtest.so", RTLD_LAZY);
	const char *err = dlerror();
	if (err != NULL) {
		perror("Could not open shared lib.\n");
	}

	fn = dlsym(handle, "testA");
	fn();
	fn = dlsym(handle, "testB");
	fn();
	fn = dlsym(handle, "testC");
	fn();
	dlclose(handle);
	return 0;
}

