#include "Vtest.h"
#include "verilated.h"
int main(int argc, char** argv, char** env) {
    Verilated::commandArgs(argc, argv);
    Vtest* top = new Vtest;
    while (!Verilated::gotFinish()) { top->eval(); }
    delete top;
    exit(0);
}
