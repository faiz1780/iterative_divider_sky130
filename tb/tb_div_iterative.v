`timescale 1ns/1ps

module tb_div_iterative;

    // clock & reset
    logic clk;
    logic rst_n;

    // handshake
    logic valid_in;
    logic ready_out;
    logic valid_out;
    logic ready_in;

    // data
    logic [31:0] dividend;
    logic [31:0] divisor;
    logic [31:0] quotient;
    logic [31:0] remainder;

    // DUT
    div_iterative dut (
        .clk       (clk),
        .rst_n     (rst_n),
        .valid_in  (valid_in),
        .ready_out (ready_out),
        .dividend  (dividend),
        .divisor   (divisor),
        .valid_out (valid_out),
        .ready_in  (ready_in),
        .quotient  (quotient),
        .remainder (remainder)
    );

    // clock generation: 10 ns period
    always #5 clk = ~clk;

    // main stimulus + dump
    initial begin
        // waveform dump
        $dumpfile("div.vcd");
        $dumpvars(0, tb_div_iterative);

        // initialize
        clk = 0;
        rst_n = 0;
        valid_in = 0;
        ready_in = 1;
        dividend = 0;
        divisor  = 0;

        // reset
        #20;
        rst_n = 1;

        // apply input: 13 / 3
        @(posedge clk);
        dividend = 32'd13;
        divisor  = 32'd3;
        valid_in = 1;

        @(posedge clk);
        valid_in = 0;

        // wait for result
        wait (valid_out);
        @(posedge clk);
        $display("Quotient = %0d, Remainder = %0d", quotient, remainder);

        // end simulation
        #20;
        $finish;
    end

endmodule
