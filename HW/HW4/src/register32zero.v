// 32-bit register that only holds zeros
module register32zero
(
output wire[31:0]   q,
input[31:0]		    d,
input   		    wrenable,
input   		    clk
);

    assign q = 32'b0;

endmodule
