module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    reg [2:0] state, nxt_state;
    
    always_ff @(posedge clk)
        if(reset)
            state <= 3'b000;
    	else
            state <= nxt_state;
    
    always_comb begin
        case(state)
            3'b000: nxt_state = x ? 3'b001 : 3'b000;
            3'b001: nxt_state = x ? 3'b100 : 3'b001;
            3'b010: nxt_state = x ? 3'b001 : 3'b010;
            3'b011: nxt_state = x ? 3'b010 : 3'b001;
            3'b100: nxt_state = x ? 3'b100 : 3'b011;
        endcase
    end
    
    assign z = state == 3'b011 | state == 3'b100;
endmodule
