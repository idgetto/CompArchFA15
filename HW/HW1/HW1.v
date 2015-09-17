module hw1test;
    reg A;
    reg B;

    // ~(AB)
    wire n_AB;
    wire out_AB;
    and(out_AB, A, B);
    not(n_AB, out_AB);

    // ~A+~B
    wire nA_or_nB;
    wire out_nA;
    wire out_nB;
    not(out_nA, A);
    not(out_nB, B);
    or(nA_or_nB, out_nA, out_nB);

    // ~(A+B)
    wire n_AorB;
    wire out_AorB;
    or(out_AorB, A, B);
    not(n_AorB, out_AorB);

    // ~A~B
    wire nA_and_nB;
    and(nA_and_nB, out_nA, out_nB);

    initial begin
        $display("| A | B | ~(AB) | ~A+~B | ~(A+B) | ~A~B |");
        $display("|---|---|-------|-------|--------|------|");
        A = 0; B = 0; #1
        $display("| %b | %b |   %b   |   %b   |    %b   |   %b  |", A, B, n_AB, nA_or_nB, n_AorB, nA_and_nB);
        A = 1; B = 0; #1
        $display("| %b | %b |   %b   |   %b   |    %b   |   %b  |", A, B, n_AB, nA_or_nB, n_AorB, nA_and_nB);
        A = 0; B = 1; #1
        $display("| %b | %b |   %b   |   %b   |    %b   |   %b  |", A, B, n_AB, nA_or_nB, n_AorB, nA_and_nB);
        A = 1; B = 1; #1
        $display("| %b | %b |   %b   |   %b   |    %b   |   %b  |", A, B, n_AB, nA_or_nB, n_AorB, nA_and_nB);
    end
endmodule
