//------------------------------------------------------------------------------
// MIPS register file with a broken write enable
//   width: 32 bits
//   depth: 32 words (reg[0] is static zero register)
//   2 asynchronous read ports
//   1 synchronous, positive edge triggered write port
//------------------------------------------------------------------------------

module broken_write_enable_regfile
(
output[31:0]	ReadData1,	    // Contents of first register read
output[31:0]	ReadData2,	    // Contents of second register read
input[31:0]	    WriteData,	    // Contents to write to register
input[4:0]	    ReadRegister1,	// Address of first register to read
input[4:0]	    ReadRegister2,	// Address of second register to read
input[4:0]	    WriteRegister,	// Address of register to write
input		    RegWrite,	    // Enable writing of register when High
input		    Clk		        // Clock (Positive Edge Triggered)
);

    // decide which register to write to
    wire[31:0] register_enables;

    wire RegWriteBroken;
    not(RegWriteBroken, RegWrite);
    decoder1to32 decoder(register_enables, RegWriteBroken, WriteRegister); 

    // wire up the registers
    wire[31:0][31:0] register_outputs;
    genvar index;
    generate
        for (index = 1; index < 32;  index = index + 1)
        begin: WIRE_REGISTERS
            register32 r(register_outputs[index], 
                         WriteData, 
                         register_enables[index],
                         Clk);
        end
    endgenerate

    register32zero zero_register(register_outputs[0], 
                                 WriteData, 
                                 register_enables[0],
                                 Clk);

    // wire the read multiplexors
    mux32to1by32 read1_mux(ReadData1, ReadRegister1, register_outputs);
    mux32to1by32 read2_mux(ReadData2, ReadRegister2, register_outputs);

endmodule
