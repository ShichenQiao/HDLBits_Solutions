module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);

    wire ff1, ff2, ff3;
    always_ff @(posedge clk)
        if(!resetn) begin
            ff1 <= 1'b0;
            ff2 <= 1'b0;
            ff3 <= 1'b0;
            out <= 1'b0;
        end
   		else begin
            ff1 <= in;
            ff2 <= ff1;
            ff3 <= ff2;
            out <= ff3;
        end
            
endmodule
