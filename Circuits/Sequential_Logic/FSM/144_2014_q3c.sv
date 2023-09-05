module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
	always_comb begin
        case(y)
            3'b000: Y0 = x;
            3'b001: Y0 = !x;
            3'b010: Y0 = x;
            3'b011: Y0 = !x;
            3'b100: Y0 = !x;
            default: Y0 = 1'b0;
        endcase
    end
    
    assign z = y == 3'b011 | y == 3'b100;
endmodule
