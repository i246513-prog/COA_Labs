module Decoder(s0, s1, s2, D0, D1, D2, D3, D4, D5, D6, D7);

input s0, s1, s2;
output D0, D1, D2, D3, D4, D5, D6, D7;

wire inv0, inv1, inv2;

not (inv0, s0);
not (inv1, s1);
not (inv2, s2);

and (D0, inv0, inv1, inv2);
and (D1, inv0,   inv1, s2);
and (D2, inv0, s1,   inv2);
and (D3, inv0,   s1,   s2);
and (D4, s0, inv1, inv2);
and (D5, s0,   inv1, s2);
and (D6, s0, s1,   inv2);
and (D7, s0,   s1,   s2);

endmodule

module testbench_3x8Decoder();


reg in1 , in2 , in3;
wire  d0 , d1 , d2 , d3 , d4 , d5 , d6 , d7;


Decoder uut(in1, in2 , in3 , d0 , d1 , d2 , d3 , d4 , d5 , d6 , d7);

initial
begin

in1= 0 ; in2 = 0; in3 =0;
#50

in1= 0 ; in2 = 0; in3 =1;
#50
in1= 0 ; in2 = 1; in3 =0;
#50
in1= 0 ; in2 = 1; in3 =1;
#50
in1= 1 ; in2 = 0; in3 =0;
#50
in1= 1 ; in2 = 0; in3 =1;
#50
in1= 1 ; in2 = 1; in3 =0;
#50
in1= 1 ; in2 = 1; in3 =1;

end

endmodule
