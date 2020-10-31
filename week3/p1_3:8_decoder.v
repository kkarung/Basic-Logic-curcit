// ---------------------------------------------------------
// 3:8 Decoder Design with 2 different Coding Style
// lecture: practice in digital logic design
// week3 practice P1
// --------------------- list ---------------------
// P1A : 3:8 Decode w/ continuous assignment
// P1B : 3:8 Decoder w/ case statement
// ---------------------------------------------------------

// ------------------------------------------------
// P1A : 3:8 Decode w/ continuous assignment
// ------------------------------------------------
module dec3to8_shift (	out,	in,	en	);

output	[7:0]	out	;
input	[2:0]	in	;
input		en	;

assign out = (en == 1'b1)? 8'd1 << in  : 8'd0;

endmodule

// ------------------------------------------------
// P1B : 3:8 Decoder w/ case statement
// ------------------------------------------------
module dec3to8_case (	out,	in,	en	);

output	[7:0]	out	;
input	[2:0]	in	;
input		en	;

reg	[7:0]	out	;

always	@(*) begin
	if (en == 1'b1) begin
		case (in)
			3'b000 : out = 8'b0000_0001;
			3'b001 : out = 8'b0000_0010;
			3'b010 : out = 8'b0000_0100;
			3'b011 : out = 8'b0000_1000;
			3'b100 : out = 8'b0001_0000;
			3'b101 : out = 8'b0010_0000;
			3'b110 : out = 8'b0100_0000;
			3'b111 : out = 8'b1000_0000;
		endcase
	end else begin
		out = 8'd0;
	end
end
endmodule
