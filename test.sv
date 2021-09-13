import "DPI-C" function byte add_i8 (input byte x, input byte y);
import "DPI-C" function shortint add_i16 (input shortint x, input shortint y);
import "DPI-C" function int add_i32 (input int x, input int y);
import "DPI-C" function longint add_i64 (input longint x, input longint y);
import "DPI-C" function void add_by_output (input longint x, input longint y, output longint z);
import "DPI-C" function void xor_bit (input bit [511:0] x, input bit [511:0] y, output bit [511:0] z);
import "DPI-C" function void show_logic (input logic [127:0] x);
`ifndef VERILATOR
    import "DPI-C" function void unpacked_array (input int x[10]);
`endif
import "DPI-C" function void print (input string x);
import "DPI-C" function chandle create();
import "DPI-C" function void destroy(input chandle x);

module test;
    chandle p;
    int array[10] = '{0,1,2,3,4,5,6,7,8,9};
    longint z1;
    bit [511:0] z2;
    logic [127:0] z3;
    initial begin
        // use integral types
        $display("%x + %x = %x", 1, 2, add_i8  (1,2));
        $display("%x + %x = %x", 1, 2, add_i16 (1,2));
        $display("%x + %x = %x", 1, 2, add_i32 (1,2));
        $display("%x + %x = %x", 1, 2, add_i64 (1,2));

        // use output
        add_by_output(1,2,z1);
        $display("%x + %x = %x", 1, 2, z1);

        // use packed bit
        xor_bit('h11,'h22,z2);
        $display("%x ^ %x = %x", 'h11, 'h22, z2);

        // use logic
        z3 = 128'h0000_zzzz_xxxx_1234;
        $display("show logic value from Rust");
        show_logic(z3);

        // V erilator can't compile
        `ifndef VERILATOR
            unpacked_array(array);
        `endif

        // use string
        print("Hello World");

        // use chandle
        p = create();
        destroy(p);
        $finish;
    end
endmodule
