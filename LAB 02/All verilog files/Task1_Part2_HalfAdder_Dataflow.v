module Half_Adder(A , B , S , C);

input A , B;
output S , C;

assign S = A^B;
assign C = A&B;

endmodule  

module TestBench_Half_Adder();

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
