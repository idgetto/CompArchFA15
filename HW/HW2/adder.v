// add delay to gates
`define AND and #50
`define OR or #50
`define XOR xor #50
`define NOT not #50
`define NAND nand #50
`define NOR nor #50

module behavioralFullAdder(sum, carryout, a, b, carryin);
output sum, carryout;
input a, b, carryin;
assign {carryout, sum}=a+b+carryin;
endmodule

module structuralFullAdder(sum, carryout, a, b, carryin);
output sum, carryout;
input a, b, carryin;

// sum
// a xor b xor carryin
wire a_xor_b;
`XOR(a_xor_b, a, b);
`XOR(sum, a_xor_b, carryin);

// carryout
// (a * b) + (b * c) + (c * a)
wire a_and_b;
wire b_and_carryin;
wire carryin_and_a;
wire ab_or_bcarryin;
`AND(a_and_b, a, b);
`AND(b_and_carryin, b, carryin);
`AND(carryin_and_a, carryin, a);
`OR(ab_or_bcarryin, a_and_b, b_and_carryin);
`OR(carryout, ab_or_bcarryin, carryin_and_a);

endmodule

module testFullAdder;
reg a, b, carryin;
wire sum, carryout;
//behavioralFullAdder adder (sum, carryout, a, b, carryin);
structuralFullAdder adder (sum, carryout, a, b, carryin);

initial begin
$display("a  b carryin | carryout sum | Expected Output");
a=0;b=0;carryin=0; #1000 
$display("%b  %b    %b    |     %b     %b  |     0     0  ", a, b, carryin, carryout, sum);
a=0;b=0;carryin=1; #1000 
$display("%b  %b    %b    |     %b     %b  |     0     1  ", a, b, carryin, carryout, sum);
a=0;b=1;carryin=0; #1000 
$display("%b  %b    %b    |     %b     %b  |     0     1  ", a, b, carryin, carryout, sum);
a=0;b=1;carryin=1; #1000 
$display("%b  %b    %b    |     %b     %b  |     1     0  ", a, b, carryin, carryout, sum);
a=1;b=0;carryin=0; #1000 
$display("%b  %b    %b    |     %b     %b  |     0     1  ", a, b, carryin, carryout, sum);
a=1;b=0;carryin=1; #1000 
$display("%b  %b    %b    |     %b     %b  |     1     0  ", a, b, carryin, carryout, sum);
a=1;b=1;carryin=0; #1000 
$display("%b  %b    %b    |     %b     %b  |     1     0  ", a, b, carryin, carryout, sum);
a=1;b=1;carryin=1; #1000 
$display("%b  %b    %b    |     %b     %b  |     1     1  ", a, b, carryin, carryout, sum);
end
endmodule
