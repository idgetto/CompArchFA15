// add delay to gates
`define AND and #50
`define OR or #50
`define XOR xor #50
`define NOT not #50
`define NAND nand #50
`define NOR nor #50

module behavioralMultiplexer(out, address0,address1, in0,in1,in2,in3);
output out;
input address0, address1;
input in0, in1, in2, in3;
wire[3:0] inputs = {in3, in2, in1, in0};
wire[1:0] address = {address1, address0};
assign out = inputs[address];
endmodule

module structuralMultiplexer(out, address0,address1, in0,in1,in2,in3);
output out;
input address0, address1;
input in0, in1, in2, in3;

// in0
// in0 * ~address0 * ~address1
wire nAddr0;
wire nAddr1;
wire nAddr0_and_nAddr1;
wire in0_out;
`NOT(nAddr0, address0);
`NOT(nAddr1, address1);
`AND(nAddr0_and_nAddr1, nAddr0, nAddr1);
`AND(in0_out, in0, nAddr0_and_nAddr1);

//// use in1
//// in1 * address0 * ~address1
wire addr0_and_nAddr1;
wire in1_out;
`AND(addr0_and_nAddr1, address0, nAddr1);
`AND(in1_out, in1, addr0_and_nAddr1);
//
//// use in2
//// in2 * ~address0 * address1
wire nAddr0_and_addr1;
wire in2_out;
`AND(nAddr0_and_addr1, nAddr0, address1);
`AND(in2_out, in2, nAddr0_and_addr1);
//
//// use in3
//// in3 * address0 * address1
wire addr0_and_addr1;
wire in3_out;
`AND(addr0_and_addr1, address0, address1);
`AND(in3_out, in3, addr0_and_addr1);

wire in0_or_in1;
wire in2_or_in3;
`OR(in0_or_in1, in0_out, in1_out);
`OR(in2_or_in3, in2_out, in3_out);
`OR(out, in0_or_in1, in2_or_in3);

endmodule


module testMultiplexer;
    reg address0, address1, in0, in1, in2, in3;
    wire out;
    //behavioralMultiplexer multi (out, address0, address1, in0, in1, in2, in3);
    structuralMultiplexer multi (out, address0, address1, in0, in1, in2, in3);

    initial begin
        $dumpfile("build/multiplexer.vcd");
        $dumpvars(0, testMultiplexer);

        $display("address0 address1 in0 in1 in2 in3 | out | Expected Output");

        address0=0; address1=0; in0=0; in1=0; in2=0; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=0; in0=0; in1=0; in2=0; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=0; in0=0; in1=0; in2=1; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=0; in0=0; in1=0; in2=1; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=0; in0=0; in1=1; in2=0; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=0; in0=0; in1=1; in2=0; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=0; in0=0; in1=1; in2=1; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=0; in0=0; in1=1; in2=1; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=0; in0=1; in1=0; in2=0; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=0; in0=1; in1=0; in2=0; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=0; in0=1; in1=0; in2=1; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=0; in0=1; in1=0; in2=1; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=0; in0=1; in1=1; in2=0; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=0; in0=1; in1=1; in2=0; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=0; in0=1; in1=1; in2=1; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=0; in0=1; in1=1; in2=1; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=1; in0=0; in1=0; in2=0; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=1; in0=0; in1=0; in2=0; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=1; in0=0; in1=0; in2=1; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=1; in0=0; in1=0; in2=1; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=1; in0=0; in1=1; in2=0; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=1; in0=0; in1=1; in2=0; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=1; in0=0; in1=1; in2=1; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=1; in0=0; in1=1; in2=1; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=1; in0=1; in1=0; in2=0; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=1; in0=1; in1=0; in2=0; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=1; in0=1; in1=0; in2=1; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=1; in0=1; in1=0; in2=1; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=1; in0=1; in1=1; in2=0; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=1; in0=1; in1=1; in2=0; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=1; in0=1; in1=1; in2=1; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=0; address1=1; in0=1; in1=1; in2=1; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=0; in0=0; in1=0; in2=0; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=0; in0=0; in1=0; in2=0; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=0; in0=0; in1=0; in2=1; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=0; in0=0; in1=0; in2=1; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=0; in0=0; in1=1; in2=0; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=0; in0=0; in1=1; in2=0; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=0; in0=0; in1=1; in2=1; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=0; in0=0; in1=1; in2=1; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=0; in0=1; in1=0; in2=0; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=0; in0=1; in1=0; in2=0; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=0; in0=1; in1=0; in2=1; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=0; in0=1; in1=0; in2=1; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=0; in0=1; in1=1; in2=0; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=0; in0=1; in1=1; in2=0; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=0; in0=1; in1=1; in2=1; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=0; in0=1; in1=1; in2=1; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=1; in0=0; in1=0; in2=0; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=1; in0=0; in1=0; in2=0; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=1; in0=0; in1=0; in2=1; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=1; in0=0; in1=0; in2=1; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=1; in0=0; in1=1; in2=0; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=1; in0=0; in1=1; in2=0; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=1; in0=0; in1=1; in2=1; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=1; in0=0; in1=1; in2=1; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=1; in0=1; in1=0; in2=0; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=1; in0=1; in1=0; in2=0; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=1; in0=1; in1=0; in2=1; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=1; in0=1; in1=0; in2=1; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=1; in0=1; in1=1; in2=0; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=1; in0=1; in1=1; in2=0; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=1; in0=1; in1=1; in2=1; in3=0; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 0", address0, address1, in0, in1, in2, in3, out);

        address0=1; address1=1; in0=1; in1=1; in2=1; in3=1; #1000
        $display("   %b        %b      %b   %b   %b   %b  |  %b  | 1", address0, address1, in0, in1, in2, in3, out);
    end
endmodule
