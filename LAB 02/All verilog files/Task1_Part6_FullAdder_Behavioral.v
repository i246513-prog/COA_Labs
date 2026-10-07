module Full_Adder(x , y , cin , sum , carry) ;

input x , y , cin;

output reg sum , carry;

always @(*)
begin 
if (x == 0 && y ==0 && cin == 0)       begin sum =0 ; carry = 0; end
else if (x ==  0 && y ==0 && cin == 1) begin sum =1 ; carry = 0; end
else if (x ==  0 && y ==1 && cin == 0) begin sum =1 ; carry = 0; end
else if (x ==  0 && y ==1 && cin == 1) begin sum =0 ; carry = 1; end
else if (x ==  1 && y ==0 && cin == 0) begin sum =1 ; carry = 0; end
else if (x ==  1 && y ==0 && cin == 1) begin sum =0 ; carry = 1; end
else if (x ==  1 && y ==1 && cin == 0) begin sum =0 ; carry = 1; end
else                                   begin sum =1 ; carry = 1; end
end  


endmodule  

module testbench_FullAdder_Behavioral();

wire sum , carry;
reg in1 , in2 , in3;

Full_Adder uut(in1, in2 , in3 , sum , carry);
integer i;
initial
begin
for (i = 0 ;i < 8 ; i= i+1) begin 
{in1 , in2 , in3 } = i;
#50;
end


end

endmodule
