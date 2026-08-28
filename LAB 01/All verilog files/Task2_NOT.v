module logicgate(a,c); input a;
output c; assign c = ~a; endmodule
module testmatch(); reg x;
wire z;

logicgate aut(x,z); initial
begin

x = 0;

#50

x = 1;
end endmodule

