module top_module( 
    input [2:0] in,
    output [1:0] out );

	assign out = &in ? 2'b11:
        		 ~|in ? 2'b00 :
        		 ^in ? 2'b01:
        		 2'b10;
endmodule
