#!/bin/sh

export PATH=/project/tools/verilator/5.018/bin:$PATH
export PATH=/project/tools/gcc/12.1.0/bin:$PATH

export LD_LIBRARY_PATH=/project/tools/gcc/12.1.0/lib64:$LD_LIBRARY_PATH

#verilator --version
#rm -rf obj_dir

verilator --binary --top top \
	+incdir+../../../../../src \
	+incdir+. \
	--trace \
	sv_tlm.sv \
	smoke.sv \
	top.sv
if test $? -ne 0; then exit 1; fi

time ./obj_dir/Vtop

