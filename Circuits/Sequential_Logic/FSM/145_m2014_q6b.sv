module top_module (
    input [3:1] y,
    input w,
    output Y2);

    always_comb begin
        case(y[3:1])
            3'b000: Y2 = 1'b0;
            3'b001: Y2 = 1'b1;
            3'b010: Y2 = w;
            3'b011: Y2 = 1'b0;
            3'b100: Y2 = w;
            3'b101: Y2 = 1'b1;
            default: Y2 = 1'b0;
        endcase
    end
endmodule
