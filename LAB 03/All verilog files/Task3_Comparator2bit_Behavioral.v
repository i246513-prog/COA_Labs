module comparator_2bit (input [1:0] A, input [1:0] B, output reg Greater,  output reg Less, output reg Equal);

always @ * begin
    Greater = 1'b0;
    Less = 1'b0;
    Equal = 1'b0;

    if (A > B)
        Greater = 1'b1;
    else if (A < B)
        Less = 1'b1;
    else
        Equal = 1'b1;
end

endmodule

module tb_comparator_2bit;
    reg [1:0] A;
    reg [1:0] B;
    wire Greater;
    wire Less;
    wire Equal;

    comparator_2bit uut ( A,B, Greater, Less, Equal );

    initial begin
        A = 2'b00; B = 2'b00;
        #20;
        A = 2'b01; B = 2'b10;
        #20;
        A = 2'b11; B = 2'b01;
        #20;
        A = 2'b10; B = 2'b10;
        #20;
    end
endmodule
