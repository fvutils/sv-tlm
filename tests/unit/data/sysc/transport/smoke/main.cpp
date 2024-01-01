#include <systemc>

class producer : public sc_core::sc_module {
public:
	producer(const char *name) : sc_module(name) { }
};

class consumer : public sc_core::sc_module {
public:
	consumer(const char *name) : sc_module(name) { }
};

class my_c : public sc_core::sc_module {
public:
	producer			*init;
	consumer			*targ;

	my_c(const char *name) : sc_module(name) {
		init = new producer("init");
		targ = new consumer("targ");
	}

};

int sc_main(int argc, char **argv) {
	my_c *c = new my_c("c");

	sc_core::sc_start();
}

