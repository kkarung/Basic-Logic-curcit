// ---------------------------------------------------------
//       4:1 MUX design with 3 different Coding Style
// Course: practice in digital logic design
// Assignment: week2 assignment A1
// --------------------- list ---------------------
// 2:1 MUX (Dataflow)
// A1: 4:1 MUX Design Using 3 x 2:1 MUX
// 4:1 MUX Design Using if
// 4:1 MUX Design Using case
// ---------------------------------------------------------

// ------------------------------------------------
// 2:1 MUX (Dataflow)
// ------------------------------------------------
module	mux2(	y, d0, d1, s	)	;

parameter		N = 8	;

output	[N-1:0]		y	; // output
input	[N-1:0]		d0	; // input d0
input	[N-1:0]		d1	; // input d1
input			s	; // select

assign			y = s ? d1 : d0	;

endmodule

// ------------------------------------------------
// A1: 4:1 MUX Design Using 3 x 2:1 MUX
// ------------------------------------------------
module mux4 (	y, d0, d1, d2, d3, s	);

parameter		N = 8	;

output	[N-1:0]		y	; // output
input	[N-1:0]		d0	; // input d0
input	[N-1:0]		d1	; // input d1
input	[N-1:0]		d2	; // input d2
input	[N-1:0]		d3	; // input d3
input	[1:0]		s	; // select

wire	[N-1:0]		node1	; // mux_0? ??
wire	[N-1:0]		node2	; // mux_1? ??

mux2	mux_0	( .y ( node1 ), .d0 ( d0 ), .d1 ( d1 ), .s ( s[0] ));
mux2	mux_1	( .y ( node2 ), .d0 ( d2 ), .d1 ( d3 ), .s ( s[0] ));
mux2	mux_2	( .y ( y ), .d0 ( node1 ), .d1 ( node2 ), .s ( s[1] ));

endmodule

// ------------------------------------------------
// 4:1 MUX Design Using if
// ------------------------------------------------
module mux4_if (	y, d0, d1, d2, d3, s	);

parameter	N = 8	;

output	[N-1:0]	y	;
input	[N-1:0]	d0	;
input	[N-1:0]	d1	;
input	[N-1:0]	d2	;
input	[N-1:0]	d3	;
input	[1:0]	s	;

reg	[N-1:0]	y	;

always @(*) begin
	if (s == 2'b00) begin
		y = d0;
	end else if (s == 2'b01) begin
		y = d1;
	end else if (s == 2'b10) begin
		y = d2;
	end else begin
		y = d3;
	end
end
endmodule

// ------------------------------------------------
// 4:1 MUX Design Using case
// ------------------------------------------------
module mux4_case (	y, d0, d1, d2, d3, s	);

parameter	N = 8;

output	[N-1:0]	y	;
input	[N-1:0]	d0	;
input	[N-1:0]	d1	;
input	[N-1:0]	d2	;
input	[N-1:0]	d3	;
input	[1:0]	s	;

reg	[N-1:0]	y	;

always @(*) begin
	case (s)
		2'b00: y = d0;
		2'b01: y = d1;
		2'b10: y = d2;
		2'b11: y = d3;
	endcase
end
endmodule
