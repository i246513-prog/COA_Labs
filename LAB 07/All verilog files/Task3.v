module ALU #(parameter bits_len = 32) ( input [bits_len-1:0] A , input [bits_len-1:0]B, input [2:0]op_code , output [bits_len -1:0] result );

	wire [bits_len - 1:0] add_result;
	wire [bits_len - 1:0] sub_result;
	wire [bits_len - 1:0] and_result;
	wire [bits_len - 1:0] or_result;
	wire [bits_len - 1:0] xor_result;
	wire [bits_len - 1:0] xnor_result;



	assign add_result = A + B;
	assign  sub_result = A - B;
	assign and_result 	= 	 A&B;
	assign or_result  	= 	 A|B;
	assign xor_result 	= 	 A^B;
	assign xnor_result 	=  ~(A^B);

	wire s0 , s1 , s2 ;

	not (s0 , op_code[0]);
	not (s1 , op_code[1]);
	not (s2 , op_code[2]);



	// now doing utilizing the mux for selection the right operation 
	
	wire [bits_len - 1:0] w0 , w1 , w2  , w3,w4 , w5 ;

	
	genvar i;	

	generate 
	for ( i = 0 ; i < bits_len ; i = i + 1) begin : mux_gates 

		and(w0[i] , add_result[i] , s2 , s1 , s0);

		and(w1[i] , sub_result[i] , s2 , s1 , op_code[0]);
	

		and(w2[i] , and_result[i] , s2 , op_code[1] , s0);

		and (w3[i] , or_result[i] , s2 , op_code[1] , op_code[0]);

		and (w4[i], xor_result[i] , op_code[2] , s1 , s0 );
			
		and (w5[i] , xnor_result[i] , op_code[2] , s1 , op_code[0]);



		or (result[i] , w0[i] , w1[i] , w2[i] ,w3[i] , w4[i] , w5[i] );
	end
	
	endgenerate 
endmodule 





module test_bench_ALU;

// using 8 bit ALU we made the ALU which can perfrom any N bits operation
parameter width = 8;
reg [width - 1 :0] a , b;

reg [2:0] op;
wire [width - 1 :0] res;


ALU #(.bits_len(width) ) alu(.A(a) , .B(b) , .op_code(op) , .result(res) );


	
initial begin 
	
    // ADD opcode is 000
    a = 'h0A; b = 'h0B; op = 3'b000;
    #10;

    // Test 2: ADD 255 + 1 = 256 (Carry = 1)
    a = 'hFF; b = 'h01; op = 3'b000;
    #10;

    // Test 3: SUB 20 - 10 = 10
    a = 'h14; b = 'h0A; op = 3'b001;
    #10;
    // Test 4: SUB 5 - 10 = -5
    a= 'h05; b = 'h0A; op = 3'b001;
    #10;

    // Test 5: AND 11001100 & 10101010 = 10001000
    a = 8'b11001100; b = 8'b10101010; op = 3'b010;
    #10;

    // Test 6: OR 11001100 | 10101010 = 11101110
   	a = 8'b11001100; b = 8'b10101010; op = 3'b011;
    #10;

    // Test 7: XOR 11001100 ^ 10101010 = 01100110
    a = 8'b11001100; b = 8'b10101010; op = 3'b100;
    #10;

    // Test 8: XNOR 11001100 ^~ 10101010 = 10011001
    a = 8'b11001100; b = 8'b10101010; op = 3'b101;
    #10;

     a = 'hFF; b = 'h0F; op= 3'b110;
    #10;

    // Test 10: operation which are not implemented yet will give a result of zero
    a = 'hAA; b = 'h55; op = 3'b111;
    #10;

	

end 

	

endmodule