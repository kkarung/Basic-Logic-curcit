// ---------------------------------------------------------
// 4-bit Adder Design
// lecture: practice in digital logic design
// week2 practice 02 P2A, P2B
// --------------------- list ---------------------
// 1-bit Full-Adder (Dataflow w/ Operator)
// P2A: 4-bit Adder (Heirarchical design, 1-bit FA x 4)
// P2B: 4-bit Adder (Multi-bit Expression)
// ----------------------------------------------------------

// ------------------------------------------------
// 1-bit Full-Adder (Dataflow w/ Operator)
// ------------------------------------------------
module fa (	s, co, a, b, ci	)	;

output	s	;
output	co	;
input	a	;
input	b	;
input	ci	;

assign {co, s} = a + b + ci	;

endmodule

// ------------------------------------------------
// P2A: 4-bit Adder (Heirarchical design, 1-bit FA x 4)
// ------------------------------------------------
module fa4_inst (	s, co, a, b, ci	);

output	[3:0]	s	;	// sum
output		co	;	// carry out
input	[3:0]	a	;	// input a
input	[3:0]	b	;	// input b
input		ci	;	// carry in

wire	[2:0]	carry	;	// ripple carry

fa	fa_u0 ( .s ( s[0] ), .co ( carry[0] ), .a ( a[0] ), .b ( b[0] ), .ci ( ci ));

fa	fa_u1 ( .s ( s[1] ), .co ( carry[1] ), .a ( a[1] ), .b ( b[1] ), .ci ( carry[0] ));

fa	fa_u2 ( .s ( s[2] ), .co ( carry[2] ), .a ( a[2] ), .b ( b[2] ), .ci ( carry[1] ));

fa	fa_u3 ( .s ( s[3] ), .co ( co ), .a ( a[3] ), .b ( b[3] ), .ci ( carry[2] ));

endmodule

// ------------------------------------------------
// P2B: 4-bit Adder (Multi-bit Expression)
// ------------------------------------------------
module fa4_mbit (	s, co, a, b, ci	);

output	[3:0]	s	;
output		co	;
input	[3:0]	a	;
input	[3:0]	b	;
input		ci	;

assign	{co, s}	= a + b + ci	;

endmodule
