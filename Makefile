SIM_BINARY := obj_dir/Vtest

LIB_DPI += dpi/target/debug/libdpi.so

run: $(SIM_BINARY)
	cd obj_dir; ./Vtest

$(SIM_BINARY): $(LIB_DPI) test.sv sim_main.cpp
	verilator --cc test.sv ../$(LIB_DPI) --exe sim_main.cpp
	$(MAKE) -C obj_dir -f Vtest.mk Vtest

$(LIB_DPI): dpi/src/*.rs
	cd dpi; cargo build

vcs: $(LIB_DPI)
	vcs -full64 -sverilog test.sv
	./simv -sv_root ./dpi/target/debug -sv_lib libdpi

clean:
	rm -rf obj_dir
	rm -rf simv
	rm -rf simv.daidir
	rm -rf csrc
	rm -rf ucli.key
	rm -rf vc_hdrs.h
