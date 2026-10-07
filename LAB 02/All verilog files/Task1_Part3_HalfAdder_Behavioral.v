module Half_Adder(A , B , S , C);

input A , B;
output reg S , C;

always @(A or B)
begin 
S = A^B;
C = A&B;
end 
endmodule  // how are you 

module TestBench_Half_Adder_Behavioral();

reg in1 , in2 ;
wire sum , carry;

Half_Adder hd(in1 ,in2 , sum ,carry);

integer i;

initial begin 
for (i = 0 ; i < 4 ;i = i+1) begin
{in1 , in2}= i;
 #50;
end
end  
endmodule   
