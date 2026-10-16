
module ALU #(parameter bits_len = 32)(
    input [bits_len-1:0] a,
    input [bits_len-1:0] b,
    input [3:0] alu_op,
    output [bits_len-1:0] result,
    output zero
);

    // Results of all operations
    wire [bits_len-1:0] add_result;
    wire [bits_len-1:0] sub_result;
    wire [bits_len-1:0] and_result;
    wire [bits_len-1:0] or_result;
    wire [bits_len-1:0] xor_result;

    wire [bits_len-1:0] slt_result;
    wire [bits_len-1:0] sltu_result;

    wire [bits_len-1:0] sll_result;
    wire [bits_len-1:0] srl_result;
    wire [bits_len-1:0] sra_result;

    // Arithmetic operations

	// Addition result 
    assign add_result = a + b;
	// subtraction result
    assign sub_result = a - b;

    // Logical operations
	// And operation 
    assign and_result = a & b;
	// OR operation 
    assign or_result  = a | b;
	// XOR operation 
    assign xor_result = a ^ b;

    // Comparison operations
	// Signed setless than cheking 
    assign slt_result  = ($signed(a) < $signed(b)) ? 1 : 0;
	// Signed setless than cheking 
    assign sltu_result = (a < b) ? 1 : 0;

    // Shift operations
	// shift left operation 
    assign sll_result = a << b[4:0];
    assign srl_result = a >> b[4:0];
    assign sra_result = $signed(a) >>> b[4:0];

    // Opcode inverted bits
    wire s0, s1, s2, s3;

    not(s0, alu_op[0]);
    not(s1, alu_op[1]);
    not(s2, alu_op[2]);
    not(s3, alu_op[3]);

    // MUX intermediate wires
    wire [bits_len-1:0] w0, w1, w2, w3, w4;
    wire [bits_len-1:0] w5, w6, w7, w8, w9;

    genvar i;

    generate
        for(i = 0; i < bits_len; i = i + 1) begin : mux_gates

            // 0000 ADD
            and(w0[i], add_result[i], s3, s2, s1, s0);

            // 0001 SUB
            and(w1[i], sub_result[i], s3, s2, s1, alu_op[0]);

            // 0010 AND
            and(w2[i], and_result[i], s3, s2, alu_op[1], s0);

            // 0011 OR
            and(w3[i], or_result[i], s3, s2, alu_op[1], alu_op[0]);

            // 0100 XOR
            and(w4[i], xor_result[i], s3, alu_op[2], s1, s0);

            // 0101 SLT
            and(w5[i], slt_result[i], s3, alu_op[2], s1, alu_op[0]);

            // 0110 SLTU
            and(w6[i], sltu_result[i], s3, alu_op[2], alu_op[1], s0);

            // 0111 SLL
            and(w7[i], sll_result[i], s3, alu_op[2], alu_op[1], alu_op[0]);

            // 1000 SRL
            and(w8[i], srl_result[i], alu_op[3], s2, s1, s0);

            // 1001 SRA
            and(w9[i], sra_result[i], alu_op[3], s2, s1, alu_op[0]);

            // Final MUX output
            or(result[i],
                w0[i], w1[i], w2[i], w3[i], w4[i],
                w5[i], w6[i], w7[i], w8[i], w9[i]
            );

        end
    endgenerate

    // Zero flag
    assign zero = (result == 0);

endmodule




module test_bench_ALU;

    reg [31:0] a, b;
    reg [3:0] alu_op;

    wire [31:0] result;
    wire zero;

    ALU #(.bits_len(32)) alu (
        .a(a),
        .b(b),
        .alu_op(alu_op),
        .result(result),
        .zero(zero)
    );

    initial begin

        // Test 1: ADD 10 + 20 = 30
        a = 32'd10; b = 32'd20; alu_op = 4'b0000;
        #10;

        // Test 2: SUB 20 - 5 = 15
        a = 32'd20; b = 32'd5; alu_op = 4'b0001;
        #10;

        // Test 3: AND
        a = 32'h000000CC; b = 32'h000000AA; alu_op = 4'b0010;
        #10;

        // Test 4: OR
        a = 32'h000000CC; b = 32'h000000AA; alu_op = 4'b0011;
        #10;

        // Test 5: XOR
        a = 32'h000000CC; b = 32'h000000AA; alu_op = 4'b0100;
        #10;

        // Test 6: SLT (-5 < 3) = 1
        a = -5; b = 32'd3; alu_op = 4'b0101;
        #10;

        // Test 7: SLTU (5 < 10) = 1
        a = 32'd5; b = 32'd10; alu_op = 4'b0110;
        #10;

        // Test 8: SLL (5 << 2) = 20
        a = 32'd5; b = 32'd2; alu_op = 4'b0111;
        #10;

        // Test 9: SRL (16 >> 2) = 4
        a = 32'd16; b = 32'd2; alu_op = 4'b1000;
        #10;

        // Test 10: SRA (-16 >>> 2) = -4
        a = -16; b = 32'd2; alu_op = 4'b1001;
        #10;

        // Test 11: SUB 10 - 10 = 0, zero = 1
        a = 32'd10; b = 32'd10; alu_op = 4'b0001;
        #10;

        // Test 12: SLT (10 < 5) = 0, zero = 1
        a = 32'd10; b = 32'd5; alu_op = 4'b0101;
        #10;

        // Test 13: SLTU (-1 < 1 unsigned) = 0
        a = 32'hFFFFFFFF; b = 32'd1; alu_op = 4'b0110;
        #10;

        // Test 14: Reserved opcode, result = 0
        a = 32'd10; b = 32'd5; alu_op = 4'b1111;
        #10;

    end

endmodule

