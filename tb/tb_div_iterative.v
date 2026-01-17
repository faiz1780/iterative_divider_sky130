`timescale 1ns/1ps

module tb_div_iterative;

    logic clk;
    logic rst_n;

    logic valid_in;
    logic ready_out;

    logic [31:0] dividend;
    logic [31:0] divisor;

    logic valid_out;
    logic ready_in;

    logic [31:0] quotient;
    logic [31:0] remainder;

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

    // clock: 10ns period
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
        valid_in = 0;
        ready_in = 1;
        dividend = 0;
        divisor  = 0;

        #20;
        rst_n = 1;

        // Test case: 13 / 3
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


        #20;
        $finish;
    end

endmodule
