module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);

    typedef enum reg [2:0] {A, B, C, D, E, F} state_t;
    state_t state, nxt_state;
    
    always_ff @(posedge clk)
        if(reset)
            state <= A;
    	else
            state <= nxt_state;
    
    always_comb begin
        case(state)
            A: nxt_state = w ? A : B;
            B: nxt_state = w ? D : C;
            C: nxt_state = w ? D : E;
            D: nxt_state = w ? A : F;
            E: nxt_state = w ? D : E;
            F: nxt_state = w ? D : C;
            default: nxt_state = A;
        endcase
    end
    
    assign z = state == E || state == F;
endmodule
