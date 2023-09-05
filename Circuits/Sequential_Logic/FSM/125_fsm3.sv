module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    typedef enum reg [1:0] {A, B, C, D} state_t;
    state_t state, nxt_state;
    // State transition logic
	always_comb
        case(state)
            A: nxt_state = in ? B : A;
            B: nxt_state = in ? B : C;
            C: nxt_state = in ? D : A;
            D: nxt_state = in ? B : C;
        endcase
    // State flip-flops with asynchronous reset
    always_ff @(posedge clk, posedge areset)
        if(areset)
            state <= A;
    	else
            state <= nxt_state;
    // Output logic
    assign out = state == D;

endmodule
