module div_iterative (
    input  logic        clk,
    input  logic        rst_n,

    input  logic        valid_in,
    output logic        ready_out,

    input  logic [31:0] dividend,
    input  logic [31:0] divisor,

    output logic        valid_out,
    input  logic        ready_in,

    output logic [31:0] quotient,
    output logic [31:0] remainder
);

    logic load;
    logic step;
    logic done;

    div_control ctrl (
        .clk       (clk),
        .rst_n     (rst_n),
        .valid_in  (valid_in),
        .ready_in  (ready_in),
        .done      (done),
        .load      (load),
        .step      (step),
        .ready_out (ready_out),
        .valid_out (valid_out)
    );

    div_datapath data (
        .clk       (clk),
        .rst_n     (rst_n),
        .load      (load),
        .step      (step),
        .dividend  (dividend),
        .divisor   (divisor),
        .done      (done),
        .quotient  (quotient),
        .remainder (remainder)
    );

endmodule
