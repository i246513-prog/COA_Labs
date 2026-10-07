module mux2x1_logic (
    input A,
    input B,
    input Select,
    output reg Y
);

always @ * begin
    case (Select)
        1'b0: Y = A & B;
        1'b1: Y = A | B;
    endcase
end

endmodule

module tb_mux2x1_logic;
    reg A;
    reg B;
    reg Select;
    wire Y;

    mux2x1_logic uut (A,B,Select,Y);

    initial begin
        Select = 1'b0; A = 1'b0; B = 1'b1;
        #20;
        Select = 1'b0; A = 1'b1; B = 1'b1;
        #20;
        Select = 1'b1; A = 1'b1; B = 1'b0;
        #20;
        Select = 1'b1; A = 1'b0; B = 1'b0;
        #20;
    end
endmodule
