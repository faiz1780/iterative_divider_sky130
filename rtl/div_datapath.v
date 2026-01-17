module div_datapath (
    input  logic        clk,
    input  logic        rst_n,

    input  logic        load,
    input  logic        step,

    input  logic [31:0] dividend,
    input  logic [31:0] divisor,

    output logic        done,
    output logic [31:0] quotient,
    output logic [31:0] remainder
);

    logic [31:0] divs;
    logic [31:0] dvd;
    logic [31:0] quot;
    logic signed [32:0] rem;
    logic [5:0]  count;

    logic signed [32:0] rem_shifted;
    logic signed [32:0] diff;

    assign rem_shifted = {rem[31:0], dvd[31]};
    assign diff        = rem_shifted - {1'b0, divs};
    assign done        = (count == 6'd31);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            divs  <= 0;
            dvd   <= 0;
            quot  <= 0;
            rem   <= 0;
            count <= 0;
        end
        else if (load) begin
            divs  <= divisor;
            dvd   <= dividend;
            quot  <= 0;
            rem   <= 0;
            count <= 0;
        end
        else if (step) begin
            dvd <= dvd << 1;

            if (diff >= 0) begin
                rem  <= diff;
                quot <= {quot[30:0], 1'b1};
            end
            else begin
                rem  <= rem_shifted;
                quot <= {quot[30:0], 1'b0};
            end

            count <= count + 1;
        end
    end

    assign quotient  = quot;
    assign remainder = rem[31:0];

endmodule
