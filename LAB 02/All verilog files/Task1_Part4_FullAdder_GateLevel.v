module Half_Adder(a, b , s , c);

input a , b;
output s , c;

and a1(c , a, b);
xor x1(s , a , b);


endmodule

module Full_Adder(x , y , cin , sum , carry) ;

input x , y , cin;

output sum , carry;
wire t1 , t2 , t3 ;

Half_Adder h1 (x, y , t1 , t2);
Half_Adder h2(t1 ,  cin , sum  , t3);

or (carry , t3 , t2);

endmodule  

module testbench();

wire sum , carry;
reg in1 , in2 , in3;

Full_Adder uut(in1, in2 , in3 , sum , carry);

initial
begin

in1= 0 ; in2 = 0; in3 =0;
#50;

in1= 0 ; in2 = 0; in3 =1;
#50;
in1= 0 ; in2 = 1; in3 =0;
#50;
in1= 0 ; in2 = 1; in3 =1;
#50;
in1= 1 ; in2 = 0; in3 =0;
#50;
in1= 1 ; in2 = 0; in3 =1;
#50;
in1= 1 ; in2 = 1; in3 =0;
#50;
in1= 1 ; in2 = 1; in3 =1;
#50;
end

endmodule
