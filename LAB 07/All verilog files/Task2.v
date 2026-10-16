
module adder_1bit(input A, input B, input cin, input b_in, output res, output cout);

    // b_in = 0 for addition
    // b_in = 1 for subtraction
    wire B_invert;

    xor(B_invert, B, b_in);

    wire r1, a1, a2;

    xor(r1, B_invert, A);

    and(a1, A, B_invert);

    xor(res, r1, cin);

    and(a2, r1, cin);

    or(cout, a1, a2);

endmodule


// 1-bit ALU
module Alu_1bit(
    input A, B,
    input cin, b_in,
    input [2:0] op_code,
    input less,
    output result, cout
);

    wire and_result, or_result;
    wire add_result;

    wire s0_not, s1_not, s2_not;
    wire w0, w1, w2, w3, w4;
    wire add_select;

    // logical operations
    and(and_result, A, B);
    or(or_result, A, B);

    // addition and subtraction
    adder_1bit add1(
        .A(A),
        .B(B),
        .cin(cin),
        .b_in(b_in),
        .res(add_result),
        .cout(cout)
    );

    // MUX selection logic
    not(s0_not, op_code[0]);
    not(s1_not, op_code[1]);
    not(s2_not, op_code[2]);

    // ADD (000) or SUB (001)
    and(add_select, s2_not, s1_not);

    and(w0, add_result, add_select);

    // AND (010)
    and(w1, and_result, s2_not, op_code[1], s0_not);

    // OR (011)
    and(w2, or_result, s2_not, op_code[1], op_code[0]);

    // SLT (100)
    and(w3, less, op_code[2], s1_not, s0_not);

    // Reserved for additional operation
    buf(w4, 1'b0);

    // Final selected result
    or(result, w0, w1, w2, w3, w4);

endmodule



// 4-bit ALU using four 1-bit ALUs
module ALU_4bit(
    input [3:0] A,
    input [3:0] B,
    input [2:0] op_code,
    output [3:0] result,
    output CF, SF, ZF, OF
);

    wire b_in;
    wire c1, c2, c3, c4;

    wire [3:0] alu_result;

    wire slt_result;
    wire subtraction_sign;
    wire overflow_internal;

    // SUB and SLT require subtraction
    assign b_in = (op_code == 3'b001) ||
                  (op_code == 3'b100);

    // first 1-bit ALU
    Alu_1bit alu0(
        .A(A[0]),
        .B(B[0]),
        .cin(b_in),
        .b_in(b_in),
        .op_code(op_code),
        .less(slt_result),
        .result(alu_result[0]),
        .cout(c1)
    );

    // second 1-bit ALU
    Alu_1bit alu1(
        .A(A[1]),
        .B(B[1]),
        .cin(c1),
        .b_in(b_in),
        .op_code(op_code),
        .less(1'b0),
        .result(alu_result[1]),
        .cout(c2)
    );

    // third 1-bit ALU
    Alu_1bit alu2(
        .A(A[2]),
        .B(B[2]),
        .cin(c2),
        .b_in(b_in),
        .op_code(op_code),
        .less(1'b0),
        .result(alu_result[2]),
        .cout(c3)
    );

    // fourth 1-bit ALU
    Alu_1bit alu3(
        .A(A[3]),
        .B(B[3]),
        .cin(c3),
        .b_in(b_in),
        .op_code(op_code),
        .less(1'b0),
        .result(alu_result[3]),
        .cout(c4)
    );

    // Signed comparison for SLT
    // Sign of A-B = A[3] XOR B[3] XOR c3
    xor(subtraction_sign, A[3], B[3], 1'b1, c3);

    // Signed arithmetic overflow
    xor(overflow_internal, c3, c4);

    // SLT = sign of subtraction XOR overflow
    xor(slt_result, subtraction_sign, overflow_internal);

    // Final result  -> buff only copy on thing to other a empty gate or just a connection 
    buf(result[0], alu_result[0]);
    buf(result[1], alu_result[1]);
    buf(result[2], alu_result[2]);
    buf(result[3], alu_result[3]);

    // Carry flag for addition and subtraction
    assign CF = ((op_code == 3'b000) ||
                 (op_code == 3'b001)) ? c4 : 1'b0;

    // Sign flag
    buf(SF, result[3]);  // it will copy the MSB of the result if MSB is 1 which me the answer is neqative 

    // Zero flag
    nor(ZF, result[0], result[1], result[2], result[3]);  // if result all bits are zero which mean they are equal
						// if substraction was performed on equal A , B and it nor will invert the final 
						// answer the result all bit if zero then it will invert to 1 and will assign it to 
						// to ZF (zero flag) mean they are equal

    // Overflow flag for ADD and SUB
    assign OF = ((op_code == 3'b000) || (op_code == 3'b001)) ? overflow_internal : 1'b0;   // it will set the flag only when the opcode is for ADD or SUB 
	// other wise it will assign a one bit zero to it 1'b0

endmodule



// Testbench
module tb;

    reg [3:0] A, B;
    reg [2:0] op_code;

    wire [3:0] result;
    wire CF, SF, ZF, OF;

    ALU_4bit uut(
        .A(A),
        .B(B),
        .op_code(op_code),
        .result(result),
        .CF(CF),
        .SF(SF),
        .ZF(ZF),
        .OF(OF)
    );

    initial begin


       
        A=4'b0101; B=4'b0011; op_code=3'b000;
        #10;

        A=4'b1111; B=4'b0001; op_code=3'b000;
        #10;

        A=4'b0111; B=4'b0011; op_code=3'b000;
        #10;

        
        A=4'b1000; B=4'b0011; op_code=3'b001;
        #10;

    
        A=4'b0011; B=4'b0101; op_code=3'b001;
        #10;

        
        A=4'b1100; B=4'b1010; op_code=3'b010;
        #10;

    
        A=4'b1111; B=4'b0000; op_code=3'b010;
        #10;

   
        A=4'b1010; B=4'b0101; op_code=3'b011;
        #10;

    
        A=4'b1000; B=4'b0001; op_code=3'b011;
        #10;

        A=4'b0011; B=4'b0101; op_code=3'b100;
        #10;

        A=4'b0111; B=4'b0010; op_code=3'b100;
        #10;

      
        A=4'b1101; B=4'b0010; op_code=3'b100;
        #10;

   
        A=4'b0111; B=4'b1000; op_code=3'b100;
        #10;

   
        A=4'b0100; B=4'b0100; op_code=3'b100;
        #10;



    end

endmodule

