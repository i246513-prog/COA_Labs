module logicgate (a,b,c,d,w,x,y,z);
input a,b,c,d;
output w,x,y,z ;
not a1(w,a);
not a2(x,b);
not a3(y,c);
not a4(z,d);
endmodule
module testbench();
reg a;
reg b;
reg c;
reg d;
wire w;
wire x;
wire y;
wire z;
integer i;
logicgate aut(a,b,c,d,w,x,y,z);
initial
begin
	for(i=0; i<16; i=i+1)
	begin
	{a,b,c,d} = i;
	#50;
	end
end
endmodule




