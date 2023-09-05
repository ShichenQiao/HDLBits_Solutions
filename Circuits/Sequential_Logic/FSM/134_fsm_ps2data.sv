module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
    typedef enum reg [1:0] {IDLE, ONE, TWO, DONE} state_t;
    state_t state, nxt_state;
    // State transition logic (combinational)
    always_ff @(posedge clk)
        if(reset)
            state <= IDLE;
    	else
            state <= nxt_state;
    // State flip-flops (sequential)
 	always_comb begin
        case(state)
            IDLE: nxt_state = in[3] ? ONE : IDLE;
            ONE: nxt_state = TWO;
            TWO: nxt_state = DONE;
            DONE: nxt_state = in[3] ? ONE : IDLE;
        endcase
    end
    // Output logic
    assign done = state == DONE;
    // New: Datapath to store incoming bytes.
    always_ff @(posedge clk)
        if(state == IDLE)
            out_bytes <= {16'h0000, in};
    	else
            out_bytes <= {out_bytes[16:0], in};

endmodule
