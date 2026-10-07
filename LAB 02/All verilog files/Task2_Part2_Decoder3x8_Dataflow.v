module Decoder(s0, s1, s2, D0, D1, D2, D3, D4, D5, D6, D7);

input s0, s1, s2;
output D0, D1, D2, D3, D4, D5, D6, D7;

assign D0 = !s0 & !s1 & !s2;
assign D1 = !s0 & !s1 & s2;
assign D2 = !s0 & s1 & !s2;
assign D3 = !s0 & s1 & s2;
assign D4 = s0 & !s1 & !s2;
assign D5 = s0 & !s1 & s2;
assign D6 = s0 & s1 & !s2;
assign D7 = s0 & s1 & s2;

endmodule

module testbench_3x8Decoder_DataFlow();


reg in1 , in2 , in3;
wire  d0 , d1 , d2 , d3 , d4 , d5 , d6 , d7;


Decoder uut(in1, in2 , in3 , d0 , d1 , d2 , d3 , d4 , d5 , d6 , d7);

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

end

endmodule
