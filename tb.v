`timescale 1ns/1ps

module abc_tb;

  reg  clk, rst, en;
  wire out;

  // DUT
  abc dut (
    .clk(clk),
    .rst(rst),
    .en(en),
    .out(out)
  );

  // Clock: 10 ns period
  initial clk = 0;
  always #5 clk = ~clk;

  // Waveform dump
  initial begin
    $dumpfile("abc_tb.vcd");
    $dumpvars(0, abc_tb);   // dumps tb + dut hierarchy, including p_state/n_state
  end

  // Console monitor
  initial begin
    $monitor("t=%0t | clk=%b rst=%b en=%b | p_state=%0d n_state=%0d | out=%b",
             $time, clk, rst, en, dut.p_state, dut.n_state, out);
  end

  // Stimulus
  initial begin
    // Initial values, reset asserted (active low)
    rst = 0; en = 0;
    #12 rst = 1;            // release reset

    // Run through a full cycle (8 states) with en = 1
    #5  en = 1;
    #85;

    // Hold: en = 0, state should freeze
    en = 0;
    #30;

    // Resume
    en = 1;
    #40;

    // Async reset in the middle of operation
    #3  rst = 0;
    #12 rst = 1;
    #40;

    $display("Simulation finished");
    $finish;
  end

endmodule
