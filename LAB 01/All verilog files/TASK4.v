module logicgate(a,b,c); input a;
input b; output c; wire x; wire y; wire z1; wire z2; not a1(x,a); 
not a2(y,b);

and a3(z1,x,b);

and a4(z2,a,y);

or a5(c,z1,z2); endmodule
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


