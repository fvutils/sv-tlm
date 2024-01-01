#include <systemc>
#include <tlm>

using namespace sc_core;
using namespace tlm;

class producer : public sc_core::sc_module {
public:
    sc_export<tlm_transport_if<int, int> >       port;
    SC_HAS_PROCESS(producer);
	producer(const sc_module_name &name) : sc_module(name) { 
        SC_THREAD(proc_thread);
    }

    void proc_thread() {
        for (uint32_t i=0; i<1000000; i++) {
            int rsp = port->transport(i);
        }
    }
};

class consumer : 
    public virtual tlm_transport_if<int,int>, 
    public sc_core::sc_module {
public:
    SC_HAS_PROCESS(consumer);

    sc_export<tlm_transport_if<int, int> >       exp;
    int32_t                                      m_idx;

	consumer(const sc_module_name &name, int32_t idx) : sc_module(name) { 
        exp.bind(*this);
        m_idx = idx;
    }

    virtual int transport(const int &req) override {
        wait(sc_time(1*(m_idx+1), SC_NS));
        return req + 1;
    }

    virtual void transport(const int &req, int &rsp) override {
        rsp = req + 1;
    }
};

class my_c : public sc_core::sc_module {
public:
    std::vector<producer *>     initiators;
    std::vector<consumer *>     targets;

	my_c(const sc_module_name &name) : sc_module(name) {
        for (uint32_t i=0; i<100; i++) {
            char tmp[64];
            sprintf(tmp, "init%d", i);
            producer *init = new producer(tmp);
            sprintf(tmp, "targ%d", i);
    		consumer *targ = new consumer(tmp, i);

            init->port.bind(targ->exp);
            initiators.push_back(init);
            targets.push_back(targ);
        }
	}

};

int sc_main(int argc, char **argv) {
	my_c *c = new my_c("c");

	sc_core::sc_start();
}

