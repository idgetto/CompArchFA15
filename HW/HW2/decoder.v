// add delay to gates
`define AND and #50
`define OR or #50
`define XOR xor #50
`define NOT not #50
`define NAND nand #50
`define NOR nor #50

module behavioralDecoder(out0,out1,out2,out3, address0,address1, enable);
output out0, out1, out2, out3;
input address0, address1;
input enable;
assign {out3,out2,out1,out0}=enable<<{address1,address0};
endmodule

module structuralDecoder(out0,out1,out2,out3, address0,address1, enable);
output out0, out1, out2, out3;
input address0, address1;
input enable;

// output zero
// ~(add0 + add1) * enable
wire out0_val;
`NOR(out0_val, address0, address1);
`AND(out0, out0_val, enable);

// output one
// add0 * ~add1 * enable
wire n_add1;
wire out1_val;
`NOT(n_add1, address1);
`AND(out1_val, address0, n_add1);
`AND(out1, out1_val, enable);

// output two
// ~add0 * add1 * enable
wire n_add0;
wire out2_val;
`NOT(n_add0, address0);
`AND(out2_val, address1, n_add0);
`AND(out2, out2_val, enable);

// output three
// add0 * add1 * enable
wire out3_val;
`AND(out3_val, address0, address1);
`AND(out3, out3_val, enable);

endmodule

module testDecoder; 
    reg addr0, addr1;
    reg enable;
    wire out0,out1,out2,out3;
    //behavioralDecoder decoder (out0,out1,out2,out3,addr0,addr1,enable);
    structuralDecoder decoder (out0,out1,out2,out3,addr0,addr1,enable); // Swap after testing

    initial begin
        $dumpfile("decoder.vcd");
        $dumpvars(0, testDecoder);

        $display("En A0 A1| O0 O1 O2 O3 | Expected Output");
        enable=0;addr0=0;addr1=0; #1000 
        $display("%b  %b  %b |  %b  %b  %b  %b | All false", enable, addr0, addr1, out0, out1, out2, out3);
        enable=0;addr0=1;addr1=0; #1000
        $display("%b  %b  %b |  %b  %b  %b  %b | All false", enable, addr0, addr1, out0, out1, out2, out3);
        enable=0;addr0=0;addr1=1; #1000 
        $display("%b  %b  %b |  %b  %b  %b  %b | All false", enable, addr0, addr1, out0, out1, out2, out3);
        enable=0;addr0=1;addr1=1; #1000 
        $display("%b  %b  %b |  %b  %b  %b  %b | All false", enable, addr0, addr1, out0, out1, out2, out3);
        enable=1;addr0=0;addr1=0; #1000 
        $display("%b  %b  %b |  %b  %b  %b  %b | O0 Only", enable, addr0, addr1, out0, out1, out2, out3);
        enable=1;addr0=1;addr1=0; #1000 
        $display("%b  %b  %b |  %b  %b  %b  %b | O1 Only", enable, addr0, addr1, out0, out1, out2, out3);
        enable=1;addr0=0;addr1=1; #1000 
        $display("%b  %b  %b |  %b  %b  %b  %b | O2 Only", enable, addr0, addr1, out0, out1, out2, out3);
        enable=1;addr0=1;addr1=1; #1000 
        $display("%b  %b  %b |  %b  %b  %b  %b | O3 Only", enable, addr0, addr1, out0, out1, out2, out3);
    end
endmodule
