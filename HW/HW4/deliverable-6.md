Deliverable 6
=============

### The Decoder Implementation ###

``` verilog
module decoder1to32
(
output[31:0]    out,
input           enable,
input[4:0]      address
);
    assign out = enable<<address; 
endmodule
```

### Goal ###

The goal of purpose of a decoder is to take an input address and output **HIGH** on the corresponding line. In this case, there are 32 output lines. Accordingly, there are 5, or log2(32), input address wires.

### Explanation ###

The behavioral verilog above very simply implements a decoder. It takes a binary address and outputs the address in a one-hot encoding. This behavior is achieved by taking a 1-bit and left shifting it by the address. For example, if we are looking to output on line 5, then we would perform the following:

```
                        Outputs
                  31 . . . 5 4 3 2 1 0 <--- Output Lines
1 << 5 = 100000 = 0    0   1 0 0 0 0 0 <--- Values
```

As you can see, only output line 5 is **HIGH**.


