module adder_subtractor_4bit (input [3:0] A,input [3:0] B,input mode, output reg [3:0] result, output reg cout);

always @ * begin
    if (mode == 1'b0) begin
        {cout, result} = A + B;
    end
    else begin
        {cout, result} = A - B;
    end
end

endmodule

module tb_adder_subtractor_4bit();
    reg [3:0] A;
    reg [3:0] B;
    reg mode;
    wire [3:0] result;
    wire cout;

    adder_subtractor_4bit uut (A,B,mode,result,cout);

    initial begin
        mode = 1'b0; A = 4'd5; B = 4'd3;
        #20;
        
        mode = 1'b0; A = 4'd12; B = 4'd6;
        #20;
        
        mode = 1'b1; A = 4'd9; B = 4'd4;
        #20;
        
        mode = 1'b1; A = 4'd5; B = 4'd5;
        #20;
    end
endmodule
