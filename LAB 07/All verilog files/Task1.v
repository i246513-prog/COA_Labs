module adder_1bit(input A , input B , input cin , input b_in , output res , output cout );

	
	// M for enable bit which it is one then it will do substraction and 
	// if it is zero it will do addition 
	// The cin and M must be same 
	wire B_invert;

	xor(B_invert , B , b_in);

	wire r1, a1 , a2 ;

	xor (r1, B_invert , A );
	
	and(a1 , A , B_invert);

	xor( res , r1, cin) ;
	
	and(a2 , r1 , cin);
	
	or(cout , a1 , a2); 
		
	

endmodule 



module Alu_1bit(input A , input B , input c_in , input b_in, input [1:0] op_code , output result , output cout);

	
		
    wire and_result, or_result ;
    wire add_result, add_cout;

    // Logical operations for Anding and ORing
    and (and_result, A, B);
    or  (or_result, A, B);

    adder_1bit add1 (
        .A(A),
        .B(B),
        .cin(c_in),
        .b_in(b_in),
        .res(add_result),
        .cout(add_cout)
    );

    // MUX selection logic
    wire s0_not, s1_not;
    wire w0, w1, w2;

    not (s0_not, op_code[0]);
    not (s1_not, op_code[1]);

   // Seclecting addition/ substractio  when opcode is 00  and b_in well cause addition or substraction
    and (w0, add_result, s1_not, s0_not);

    // Selecting and result when op_code is 01
    and (w1 ,and_result , s1_not ,op_code[0]);

    // Selecting or result when op_code is 10

    and (w2, or_result , op_code[1] , s0_not);


    or (result , w0 , w1 , w2);

    // buf will copy add_cout to cout 
    buf (cout , add_cout);
	
	
endmodule





module tb_1bit;

    reg A, B, c_in, b_in;
    reg [1:0] op_code;

    wire result, carry_out;

    Alu_1bit uut (
        .A(A),
        .B(B),
        .c_in(c_in),
        .b_in(b_in),
        .op_code(op_code),
        .result(result),
        .cout(carry_out)
    );

    initial begin

   
        // Test 1: ADD 0 + 0
        A=0; B=0; c_in=0; b_in=0; op_code=2'b00;
        #10;

        // Test 2: ADD 1 + 0
        A=1; B=0; c_in=0; b_in=0; op_code=2'b00;
        #10;

        // Test 3: ADD 1 + 1
        A=1; B=1; c_in=0; b_in=0; op_code=2'b00;
        #10;

        // Test 4: SUB 1 - 1
        A=1; B=1; c_in=1; b_in=1; op_code=2'b00;
        #10;

        // Test 5: SUB 0 - 1
        A=0; B=1; c_in=1; b_in=1; op_code=2'b00;
        #10;

        // Test 6: AND 1 & 1
        A=1; B=1; c_in=0; b_in=0; op_code=2'b01;
        #10;

        // Test 7: AND 1 & 0
        A=1; B=0; c_in=0; b_in=0; op_code=2'b01;
        #10;

        // Test 8: OR 1 | 0
        A=1; B=0; c_in=0; b_in=0; op_code=2'b10;
        #10;

        // Test 9: Reserved operation
        A=0; B=0; c_in=0; b_in=0; op_code=2'b11;
        #10;


    end

endmodule
