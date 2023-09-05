module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 

    typedef enum reg [3:0] {A, B, C, D, E, F, G, H, BUFF} state_t;
    state_t state, nxt_state;
    
    always_ff @(posedge clk)
        if(!resetn)
            state <= A;
    	else
            state <= nxt_state;
    
    always_comb begin
        f = 1'b0;
        nxt_state = state;
        
        case(state)
            A: nxt_state = BUFF;
            BUFF: begin
                f = 1'b1;
                nxt_state = B;
            end
            B: nxt_state = x ? C : B;
            C: nxt_state = x ? C : D;
            D: nxt_state = x ? E : B;
            E: nxt_state = y ? G : F;
            F: nxt_state = y ? G : H;
            default: nxt_state = state;
        endcase
    end
    
    assign g = state == E | state == F | state == G;
    
endmodule
