module Half_Adder(a, b , s , c);

input a , b;
output reg s , c;


assign s =  a^b;
assign c = a&b;


endmodule

module Full_Adder(x , y , cin , sum , carry) ;

input x , y , cin;

output sum , carry;
wire t1 , t2 , t3 ;

Half_Adder h1 (x, y , t1 , t2);
Half_Adder h2(t1 ,  cin , sum  , t3);

assign  carry =  t3 | t2;

endmodule  

module testbench_FullAdder_Dataflow();

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
