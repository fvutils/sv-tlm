#!/bin/sh -x

#export PATH=/project/tools/verilator/5.018/bin:$PATH
#export PATH=/project/tools/gcc/12.1.0/bin:$PATH

#export LD_LIBRARY_PATH=/project/tools/gcc/12.1.0/lib64:$LD_LIBRARY_PATH

#verilator --version
#rm -rf obj_dir

export TEST_BUILD=../../../../../../build/tests

g++ -o main main.cpp -std=c++98 \
	-I${TEST_BUILD}/include \
	-Wl,--whole-archive ${TEST_BUILD}/lib64/libsystemc.a -Wl,--no-whole-archive -lpthread
if test $? -ne 0; then exit 1; fi

#time ./obj_dir/Vtop

