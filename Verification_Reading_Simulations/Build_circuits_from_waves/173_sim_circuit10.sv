module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );

    wire nxt_state;
    
    always_ff @(posedge clk)
        state <= nxt_state;
    
    always_comb begin
        nxt_state = state;
        case(state)
            1'b0: if(a & b) nxt_state = 1'b1;
            1'b1: if(!(a | b)) nxt_state = 1'b0;
        endcase
    end
    
    assign q = state ? ! (a ^ b) : a ^ b;
endmodule
