module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//

    // assign intermediate_result1 = compare? true: false;
    wire [7:0] e, f;
    assign e = (a > b) ? b : a;
    assign f = (c > d) ? d : c;
    assign min = (e > f) ? f : e;

endmodule
