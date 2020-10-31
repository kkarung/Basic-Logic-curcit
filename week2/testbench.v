// ---------------------------------------------------------
//                       Test bench
// Course: practice in digital logic design
// Assignment: week2 practice 01,02 / assignment 01,02
// --------------------- list ---------------------
// tb for P1
// tb2 for P2
// tb3 for A1
// tb4 for A2
// ----------------------------------------------------------

module tb;
// ------------------------------------------------
// instance
// ------------------------------------------------

reg	a	;
reg	b	;
reg	ci	;

wire	s1	;
wire	co1	;
wire	s2	;
wire	co2	;
wire	s3	;
wire	co3	;

fa_dataflow dut_1 (	.s	(	s1	),
			.co	(	co1	),
			.a	(	a	),
			.b	(	b	),
			.ci	(	ci	));

fa_behavior dut_2 (	.s	(	s2	),
			.co	(	co2	),
			.a	(	a	),
			.b	(	b	),
			.ci	(	ci	));

fa_case dut_3 (	.s	(	s3	),
			.co	(	co3	),
			.a	(	a	),
			.b	(	b	),
			.ci	(	ci	));

// ------------------------------------------------
// stimulus
// ------------------------------------------------
initial begin
	$display("Dataflow Level:	s1, co1");
	$display("Behavior Level:	s2, co2");
	$display("Using case:		s3, co3");
	$display("=====================================================");
	$display("ci	a	b	co1	s1	co2	s2	co3	s3");
	$display("=====================================================");
	#(50)	{ci, a, b} = 3'b_000;	#(50)	$display("%b	%b	%b	%b	%b	%b	%b	%b	%b", ci, a, b, co1, s1, co2, s2, co3, s3);
	#(50)	{ci, a, b} = 3'b_001;	#(50)	$display("%b	%b	%b	%b	%b	%b	%b	%b	%b", ci, a, b, co1, s1, co2, s2, co3, s3);
	#(50)	{ci, a, b} = 3'b_010;	#(50)	$display("%b	%b	%b	%b	%b	%b	%b	%b	%b", ci, a, b, co1, s1, co2, s2, co3, s3);
	#(50)	{ci, a, b} = 3'b_011;	#(50)	$display("%b	%b	%b	%b	%b	%b	%b	%b	%b", ci, a, b, co1, s1, co2, s2, co3, s3);
	#(50)	{ci, a, b} = 3'b_100;	#(50)	$display("%b	%b	%b	%b	%b	%b	%b	%b	%b", ci, a, b, co1, s1, co2, s2, co3, s3);
	#(50)	{ci, a, b} = 3'b_101;	#(50)	$display("%b	%b	%b	%b	%b	%b	%b	%b	%b", ci, a, b, co1, s1, co2, s2, co3, s3);
	#(50)	{ci, a, b} = 3'b_110;	#(50)	$display("%b	%b	%b	%b	%b	%b	%b	%b	%b", ci, a, b, co1, s1, co2, s2, co3, s3);
	#(50)	{ci, a, b} = 3'b_111;	#(50)	$display("%b	%b	%b	%b	%b	%b	%b	%b	%b", ci, a, b, co1, s1, co2, s2, co3, s3);
	#(50)	$finish	;
end

endmodule

module tb2;
// ------------------------------------------------
// instance
// ------------------------------------------------
reg	[3:0]	a	;
reg	[3:0]	b	;
reg		ci	;

wire	[3:0]	s1	;
wire		co1	;
wire	[3:0]	s2	;
wire		co2	;

fa4_inst dut_1 ( .s ( s1 ), .co ( co1 ), .a ( a ), .b ( b ), .ci ( ci ));

fa4_mbit dut_2 ( .s ( s2 ), .co ( co2 ), .a ( a ), .b ( b ), .ci ( ci ));

// ------------------------------------------------
// stimulus
// ------------------------------------------------

initial begin
	$display("Using Instance:	s1, co1");
	$display("Using Multi-bit: 	s2, co2");
	$display("============================================================");
	$display("ci	a	b	co1	s1	co2	s2");
	$display("============================================================");
	#(50)	{ci, a, b} = $random();	#(50)	$display("%b	%b	%b	%b	%b	%b	%b", ci, a, b, co1, s1, co2, s2);
	#(50)	{ci, a, b} = $random();	#(50)	$display("%b	%b	%b	%b	%b	%b	%b", ci, a, b, co1, s1, co2, s2);
	#(50)	{ci, a, b} = $random();	#(50)	$display("%b	%b	%b	%b	%b	%b	%b", ci, a, b, co1, s1, co2, s2);
	#(50)	{ci, a, b} = $random();	#(50)	$display("%b	%b	%b	%b	%b	%b	%b", ci, a, b, co1, s1, co2, s2);
	#(50)	{ci, a, b} = $random();	#(50)	$display("%b	%b	%b	%b	%b	%b	%b", ci, a, b, co1, s1, co2, s2);
	#(50)	{ci, a, b} = $random();	#(50)	$display("%b	%b	%b	%b	%b	%b	%b", ci, a, b, co1, s1, co2, s2);
	#(50)	{ci, a, b} = $random();	#(50)	$display("%b	%b	%b	%b	%b	%b	%b", ci, a, b, co1, s1, co2, s2);
	#(50)	{ci, a, b} = $random();	#(50)	$display("%b	%b	%b	%b	%b	%b	%b", ci, a, b, co1, s1, co2, s2);
	#(50)	{ci, a, b} = $random();	#(50)	$display("%b	%b	%b	%b	%b	%b	%b", ci, a, b, co1, s1, co2, s2);
	#(50)	{ci, a, b} = $random();	#(50)	$display("%b	%b	%b	%b	%b	%b	%b", ci, a, b, co1, s1, co2, s2);
	#(50)	{ci, a, b} = $random();	#(50)	$display("%b	%b	%b	%b	%b	%b	%b", ci, a, b, co1, s1, co2, s2);
	#(50)	$finish;
end
endmodule

module tb3;
// ------------------------------------------------
// instance
// ------------------------------------------------

parameter 	N = 2	;

reg	[N-1:0]	d0	;
reg	[N-1:0]	d1	;
reg	[N-1:0]	d2	;
reg	[N-1:0]	d3	;
reg	[1:0]	s	;
wire	[N-1:0]	y1	;
wire	[N-1:0]	y2	;
wire	[N-1:0]	y3	;

mux4		dut_1	( .y ( y1 ), .d0 ( d0 ), .d1 ( d1 ), .d2 ( d2 ), .d3 ( d3 ), .s ( s ));
mux4_if		dut_2	( .y ( y2 ), .d0 ( d0 ), .d1 ( d1 ), .d2 ( d2 ), .d3 ( d3 ), .s ( s ));
mux4_case	dut_3	( .y ( y3 ), .d0 ( d0 ), .d1 ( d1 ), .d2 ( d2 ), .d3 ( d3 ), .s ( s ));

// ------------------------------------------------
// stimulus
// -----------------------------------------------

initial begin
	$display("Using 2:1 MUX	:	y1");
	$display("Using if	:	y2");
	$display("Using case	:	y3");
	$display("=======================================================================================================================");
	$display("d0\t\td1\t\td2\t\td3\t\ts\ty1\t\ty2\t\ty3");
	$display("=======================================================================================================================");
	#(50)	{s, d0, d1, d2, d3} = $random();	#(50)	$display("%b\t\t%b\t\t%b\t\t%b\t\t%b\t%b\t\t%b\t\t%b", d0, d1, d2, d3, s, y1, y2, y3);
	#(50)	{s, d0, d1, d2, d3} = $random();	#(50)	$display("%b\t\t%b\t\t%b\t\t%b\t\t%b\t%b\t\t%b\t\t%b", d0, d1, d2, d3, s, y1, y2, y3);
	#(50)	{s, d0, d1, d2, d3} = $random();	#(50)	$display("%b\t\t%b\t\t%b\t\t%b\t\t%b\t%b\t\t%b\t\t%b", d0, d1, d2, d3, s, y1, y2, y3);
	#(50)	{s, d0, d1, d2, d3} = $random();	#(50)	$display("%b\t\t%b\t\t%b\t\t%b\t\t%b\t%b\t\t%b\t\t%b", d0, d1, d2, d3, s, y1, y2, y3);
	#(50)	{s, d0, d1, d2, d3} = $random();	#(50)	$display("%b\t\t%b\t\t%b\t\t%b\t\t%b\t%b\t\t%b\t\t%b", d0, d1, d2, d3, s, y1, y2, y3);
	#(50)	{s, d0, d1, d2, d3} = $random();	#(50)	$display("%b\t\t%b\t\t%b\t\t%b\t\t%b\t%b\t\t%b\t\t%b", d0, d1, d2, d3, s, y1, y2, y3);
	#(50)	{s, d0, d1, d2, d3} = $random();	#(50)	$display("%b\t\t%b\t\t%b\t\t%b\t\t%b\t%b\t\t%b\t\t%b", d0, d1, d2, d3, s, y1, y2, y3);
	#(50)	$finish;
end
endmodule

module tb4;
// ------------------------------------------------
// instance
// ------------------------------------------------

parameter	N = 2	;

reg		clk	;
reg		rst_n	;
wire	[N-1:0]	cnt	;

initial		clk = 1'b0	; // clock setting
always #(100)	clk = ~clk	; // clock reverse

counter	dut_1 ( .cnt ( cnt ), .clk ( clk ), .rst_n ( rst_n ));

// ------------------------------------------------
// stimulus
// -----------------------------------------------
initial begin
	$display("==================================");
	$display("cnt\t\tclk\trst_n");
	$display("==================================");
	#(0)	rst_n = 1'b0;	#(50)	$display("%b\t\t%b\t%b", cnt, clk, rst_n);
	#(50)	rst_n = 1'b1;	#(50)	$display("%b\t\t%b\t%b", cnt, clk, rst_n);
	#(50)	rst_n = 1'b1;	#(50)	$display("%b\t\t%b\t%b", cnt, clk, rst_n);
	#(50)	rst_n = 1'b1;	#(50)	$display("%b\t\t%b\t%b", cnt, clk, rst_n);
	#(50)	rst_n = 1'b1;	#(50)	$display("%b\t\t%b\t%b", cnt, clk, rst_n);
	#(50)	rst_n = 1'b1;	#(50)	$display("%b\t\t%b\t%b", cnt, clk, rst_n);
	#(50)	rst_n = 1'b1;	#(50)	$display("%b\t\t%b\t%b", cnt, clk, rst_n);
	#(50)	rst_n = 1'b1;	#(50)	$display("%b\t\t%b\t%b", cnt, clk, rst_n);
	#(50)	rst_n = 1'b1;	#(50)	$display("%b\t\t%b\t%b", cnt, clk, rst_n);
	$finish;
end
endmodule
