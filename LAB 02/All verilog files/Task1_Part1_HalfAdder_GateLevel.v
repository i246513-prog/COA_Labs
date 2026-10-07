module Half_Adder(a, b , s , c);

input a , b;
output s , c;

and a1(c , a, b);
xor x1(s , a , b);


endmodule

module testbench();

wire sum , carry;
reg in1 ;
reg in2 ;



Half_Adder uut(in1, in2 , sum , carry);

initial
begin

in1= 0 ; in2 = 0;
#50;

in1= 0 ; in2 = 1;
#50;

in1= 1 ; in2 = 0;
#50;

in1= 1 ; in2 = 1;
#50;
end

endmodule
