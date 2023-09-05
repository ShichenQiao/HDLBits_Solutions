module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 

    typedef enum reg[1:0] {A, B, C, D} state_t;
    state_t state, nxt_state;
    
    always_ff @(posedge clk)
        if(!resetn)
            state <= A;
    	else
            state <= nxt_state;
    
    always_comb
        case(state)
            A: begin
                if(r[1])
                    nxt_state = B;
                else if(r[2])
                    nxt_state = C;
                else if(r[3])
                    nxt_state = D;
                else
                    nxt_state = A;
            end
            B: nxt_state = r[1] ? B : A;
            C: nxt_state = r[2] ? C : A;
            D: nxt_state = r[3] ? D : A;
        endcase

    assign g[1] = state == B;
    assign g[2] = state == C;
    assign g[3] = state == D;
    
endmodule
