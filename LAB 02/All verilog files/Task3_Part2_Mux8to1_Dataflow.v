module MUX_8to1 ( s0, s1, s2,i0, i1, i2, i3, i4, i5, i6, i7, out);

    input s0 , s1 , s2;

    input i0, i1, i2, i3, i4, i5, i6, i7;

    output out;

    assign out = (i0 & !s0 & !s1 & !s2) |

             (i1 & !s0 & !s1 &  s2) |

             (i2 & !s0 &  s1 & !s2) |

             (i3 & !s0 &  s1 &  s2) |

             (i4 &  s0 & !s1 & !s2) |

             (i5 &  s0 & !s1 &  s2) |

             (i6 &  s0 &  s1 & !s2) |

             (i7 &  s0 &  s1 &  s2);



endmodule

module TestBench_MuxDataflow();



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
