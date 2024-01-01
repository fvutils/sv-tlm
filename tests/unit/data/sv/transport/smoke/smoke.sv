
package smoke;
import sv_tlm::*;

class initiator;
    tlm_port #(tlm_transport_if #(int, int)) port;

    function new();
        port = new("port");
    endfunction

    task run();
        for (int i=0; i<1_000_000; i++) begin
            int rsp;
            port.impl().transport(i, rsp);

            if (rsp != i+1) begin
                $display("FATAL: Expect %0d ; receive %0d", i+1, rsp);
            end
        end
    endtask

endclass

class target implements tlm_transport_if #(int, int);
    tlm_export #(tlm_transport_if #(int, int)) exp;
    int m_idx;

    function new(int idx);
        exp = new(this);
        m_idx = idx;
    endfunction


    task transport(int req, ref int rsp);
        #(1ns * (m_idx+1));
        rsp = req + 1;
    endtask

endclass

class test;
    initiator       initiators[$];
    target          targets[$];

    function new();
        for (int i=0; i<100; i++) begin
            initiator       init;
            target          targ;
            init = new();
            targ = new(i);
            init.port.bind_exp(targ.exp);
            initiators.push_back(init);
            targets.push_back(targ);
        end
    endfunction

    task run();
        for (int i=0; i<100; i++) begin
            fork
                initiators[i].run();
            join_none
        end
        wait fork;
        $finish();
    endtask

endclass

endpackage
