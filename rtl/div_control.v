module div_control (
    input  logic clk,
    input  logic rst_n,

    input  logic valid_in,
    input  logic ready_in,
    input  logic done,

    output logic load,
    output logic step,
    output logic ready_out,
    output logic valid_out
);

    typedef enum logic [1:0] {
        IDLE,
        LOAD,
        RUN,
        DONE
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= IDLE;
        else
            state <= next_state;
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE: if (valid_in) next_state = LOAD;
            LOAD:              next_state = RUN;
            RUN:  if (done)    next_state = DONE;
            DONE: if (ready_in)next_state = IDLE;
            default:           next_state = IDLE;
        endcase
    end

    assign load      = (state == LOAD);
    assign step      = (state == RUN);
    assign ready_out = (state == IDLE);
    assign valid_out = (state == DONE);

endmodule
