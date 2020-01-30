import "DPI-C" function byte add_i8 (input byte x, input byte y);
import "DPI-C" function shortint add_i16 (input shortint x, input shortint y);
import "DPI-C" function int add_i32 (input int x, input int y);
import "DPI-C" function longint add_i64 (input longint x, input longint y);
import "DPI-C" function void add_by_output (input longint x, input longint y, output longint z);
import "DPI-C" function void xor_logic (input bit [511:0] x, input bit [511:0] y, output [511:0] z);
import "DPI-C" function void packed_array (input int x[10]);
import "DPI-C" function void print (input string x);
import "DPI-C" function chandle create();
import "DPI-C" function void destroy(input chandle x);

module test;
    chandle p;
    int array[10] = '{0,1,2,3,4,5,6,7,8,9};
    longint z1;
    bit [511:0] z2;
    initial begin
        // use integral types
        $display("%x + %x = %x", 1, 2, add_i8  (1,2));
        $display("%x + %x = %x", 1, 2, add_i16 (1,2));
        $display("%x + %x = %x", 1, 2, add_i32 (1,2));
        $display("%x + %x = %x", 1, 2, add_i64 (1,2));

        // use output
        add_by_output(1,2,z1);
        $display("%x + %x = %x", 1, 2, z1);

        // use unpacked bit
        xor_logic('h11,'h22,z2);
        $display("%x ^ %x = %x", 'h11, 'h22, z2);

        // V erilator can't compile
        `ifndef VERILATOR
            packed_array(array);
        `endif

        // use string
        print("Hello World");

        // use chandle
        p = create();
        destroy(p);
        $finish;
    end
endmodule
