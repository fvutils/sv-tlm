
package smoke;
import sv_tlm::*;

class initiator;
    tlm_port #(tlm_transport_if #(int, int)) port;

    function new();
        port = new("port");
    endfunction

    task run();
        for (int i=0; i<100_000_000; i++) begin
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

    function new();
        exp = new(this);
    endfunction


    task transport(int req, ref int rsp);
        rsp = req + 1;
    endtask

endclass

class test;
    initiator       init;
    target          targ;

    function new();
        init = new();
        targ = new();
        init.port.bind_exp(targ.exp);
    endfunction

    task run();
        init.run();
        $finish();
    endtask

endclass

endpackage
