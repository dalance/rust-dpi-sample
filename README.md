# rust-dpi-sample

This is an example project using Rust from System Verilog DPI.
You can try like below:

```console
$ make

...

[src/lib.rs:49] a = "Hello World"
Object { x: 10000, y: "Hello" } is destroied
00000001 + 00000002 = 03
00000001 + 00000002 = 0003
00000001 + 00000002 = 00000003
00000001 + 00000002 = 0000000000000003
00000001 + 00000002 = 0000000000000003
00000011 ^ 00000022 = 942ed14d30202b2000000003000000030000004000000000adaead00adaeadc00000000000000000000000000000000000000000000000000000000000000033
- test.sv:43: Verilog $finish
```

The default target of `Makefile` uses [Verilator](https://www.veripool.org/wiki/verilator) as System Verilog simulator.
If you can use Synopsys VCS, `make vcs` can be used.


# Source code example

## Rust side

`#[no_mangle]` and `extern "C"` is required.

```rust
#[no_mangle]
pub extern "C" fn add_i8(x: i8, y: i8) -> i8 {
    x + y
}
```

## System Verilog side

```system_verilog
import "DPI-C" function byte add_i8 (input byte x, input byte y);
```
