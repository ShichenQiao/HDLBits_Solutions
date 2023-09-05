module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 

    assign out = (!b & c) | (a & c) | (a & !d) ? 1'b1: (a & !c & d) | (!a & b & !c & !d) ? d : 1'b0;
endmodule
