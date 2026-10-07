module MUX_8to1 ( s0, s1, s2,i0, i1, i2, i3, i4, i5, i6, i7, out);

    input s0 , s1 , s2;
    input i0, i1, i2, i3, i4, i5, i6, i7;
    output out;
    wire inv0, inv1, inv2;
    not (inv0, s0);
    not (inv1, s1);
    not (inv2, s2);
    wire D0, D1, D2, D3, D4, D5, D6, D7;
    and (D0, i0, inv0, inv1, inv2); // 000
    and (D1, i1, inv0, inv1, s2);   // 001
    and (D2, i2, inv0, s1,   inv2); // 010
    and (D3, i3, inv0, s1,   s2);   // 011
    and (D4, i4, s0,   inv1, inv2); // 100
    and (D5, i5, s0,   inv1, s2);   // 101
    and (D6, i6, s0,   s1,   inv2); // 110
    and (D7, i7, s0,   s1,   s2);   // 111

    or (out, D0, D1, D2, D3, D4, D5, D6, D7);

endmodule

module TestBench_MuxGatelevel();

reg s0, s1 ,s2;
reg  i0, i1, i2, i3, i4, i5, i6, i7;
wire Y;

MUX_8to1 uut(s0,s1,s2 , i0, i1, i2, i3, i4, i5, i6, i7 , Y);

integer i;
initial
begin
i0 = 0;
    i1 = 1;
    i2 = 0;
    i3 = 1;
    i4 = 0;
    i5 = 1;
    i6 = 0;
    i7 = 1;
for (i =0 ;i < 8; i = i+1)
begin 
{s0 , s1 ,s2 } = i;
#50;
end

end
endmodule
