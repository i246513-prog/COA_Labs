module logicgate(a,b,c); input a;
input b; output c;
assign c = a | b; endmodule
module testmatch(); reg x;
reg y; wire z;
logicgate aut(x,y,z); initial
begin

x = 0; y = 0;

#50

x = 0; y = 1;

#50
x = 1; y = 0;

#50

x = 1; y = 1;
end endmodule

