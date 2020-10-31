module tb;
// ------------------------------------------------
// instance
// ------------------------------------------------

reg	[2:0]	in	;
reg		en	;
wire	[7:0]	out1	;
wire	[7:0]	out2	;

dec3to8_shift	dut_1	( .out ( out1 ), .in ( in ), .en ( en ));
dec3to8_case	dut_2	( .out ( out2 ), .in ( in ), .en ( en ));

// ------------------------------------------------
// stimulus
// ------------------------------------------------

initial begin
#(0)	{en, in} = 4'b_0000;
#(50)	{en, in} = 4'b_1000;	#(50)	$display("%b	%b	%b	%b", out1, out2, in, en);
#(50)	{en, in} = 4'b_1001;	#(50)	$display("%b	%b	%b	%b", out1, out2, in, en);
#(50)	{en, in} = 4'b_1010;	#(50)	$display("%b	%b	%b	%b", out1, out2, in, en);
#(50)	{en, in} = 4'b_1011;	#(50)	$display("%b	%b	%b	%b", out1, out2, in, en);
#(50)	{en, in} = 4'b_1100;	#(50)	$display("%b	%b	%b	%b", out1, out2, in, en);
#(50)	{en, in} = 4'b_1101;	#(50)	$display("%b	%b	%b	%b", out1, out2, in, en);
#(50)	{en, in} = 4'b_1110;	#(50)	$display("%b	%b	%b	%b", out1, out2, in, en);
#(50)	{en, in} = 4'b_1111;	#(50)	$display("%b	%b	%b	%b", out1, out2, in, en);
#(50)	$finish;
end
endmodule

module tb2;
// ------------------------------------------------
// instance
// ------------------------------------------------

wire		q_latch		;
wire		q_dff_asyn	;
wire		q_dff_syn	;

reg		d		;
reg		clk		;
reg		rst_n		;

initial		clk = 1'b0	;
always	#(100)	clk = ~clk	;

d_latch		dut_0	( .q ( q_latch ), .d ( d ), .clk ( clk ), .rst_n ( rst_n ));
dff_asyn	dut_1	( .q ( q_dff_asyn ), .d ( d ), .clk ( clk ), .rst_n ( rst_n ));
dff_syn		dut_2	( .q ( q_dff_syn ), .d ( d ), .clk ( clk ), .rst_n ( rst_n ));

// ------------------------------------------------
// stimulus
// ------------------------------------------------

initial begin
#(0)	{rst_n, d} = 2'b00;
#(50)	{rst_n, d} = 2'b00;	#(50)	$display("%b\t%b\t%b\t%b\t%b", rst_n, d, q_latch, q_dff_asyn, q_dff_syn);
#(50)	{rst_n, d} = 2'b00;	#(50)	$display("%b\t%b\t%b\t%b\t%b", rst_n, d, q_latch, q_dff_asyn, q_dff_syn);
#(50)	{rst_n, d} = 2'b11;	#(50)	$display("%b\t%b\t%b\t%b\t%b", rst_n, d, q_latch, q_dff_asyn, q_dff_syn);
#(50)	{rst_n, d} = 2'b11;	#(50)	$display("%b\t%b\t%b\t%b\t%b", rst_n, d, q_latch, q_dff_asyn, q_dff_syn);
#(50)	{rst_n, d} = 2'b10;	#(50)	$display("%b\t%b\t%b\t%b\t%b", rst_n, d, q_latch, q_dff_asyn, q_dff_syn);
#(50)	{rst_n, d} = 2'b10;	#(50)	$display("%b\t%b\t%b\t%b\t%b", rst_n, d, q_latch, q_dff_asyn, q_dff_syn);
#(50)	{rst_n, d} = 2'b10;	#(50)	$display("%b\t%b\t%b\t%b\t%b", rst_n, d, q_latch, q_dff_asyn, q_dff_syn);
#(50)	{rst_n, d} = 2'b10;	#(50)	$display("%b\t%b\t%b\t%b\t%b", rst_n, d, q_latch, q_dff_asyn, q_dff_syn);
#(50)	{rst_n, d} = 2'b11;	#(50)	$display("%b\t%b\t%b\t%b\t%b", rst_n, d, q_latch, q_dff_asyn, q_dff_syn);
#(50)	{rst_n, d} = 2'b11;	#(50)	$display("%b\t%b\t%b\t%b\t%b", rst_n, d, q_latch, q_dff_asyn, q_dff_syn);
#(50)	{rst_n, d} = 2'b10;	#(50)	$display("%b\t%b\t%b\t%b\t%b", rst_n, d, q_latch, q_dff_asyn, q_dff_syn);
#(50)	{rst_n, d} = 2'b10;	#(50)	$display("%b\t%b\t%b\t%b\t%b", rst_n, d, q_latch, q_dff_asyn, q_dff_syn);
#(50)	{rst_n, d} = 2'b11;	#(50)	$display("%b\t%b\t%b\t%b\t%b", rst_n, d, q_latch, q_dff_asyn, q_dff_syn);
#(50)	$finish;
end
endmodule
module tb3;
// ------------------------------------------------
// instance
// ------------------------------------------------

reg	d	;
reg	clk	;

wire	q	;
wire	q_n	;

initial		clk = 1'b0	;
always	#(100)	clk = ~clk	;

dff_sr	dut_0	( .q ( q ), .q_n ( q_n ), .d ( d ), .clk ( clk ));

// ------------------------------------------------
// stimulus
// ------------------------------------------------

initial begin
#(0)	d = 1'b0;
#(50)	d = 1'b0;	#(50)	$display("%b\t%b\t%b\t%b", q, q_n, d, clk);
#(50)	d = 1'b1;	#(50)	$display("%b\t%b\t%b\t%b", q, q_n, d, clk);
#(50)	d = 1'b0;	#(50)	$display("%b\t%b\t%b\t%b", q, q_n, d, clk);
#(50)	d = 1'b1;	#(50)	$display("%b\t%b\t%b\t%b", q, q_n, d, clk);
#(50)	d = 1'b1;	#(50)	$display("%b\t%b\t%b\t%b", q, q_n, d, clk);
#(50)	d = 1'b0;	#(50)	$display("%b\t%b\t%b\t%b", q, q_n, d, clk);
#(50)	d = 1'b0;	#(50)	$display("%b\t%b\t%b\t%b", q, q_n, d, clk);
#(5)	$finish;
end
endmodule

module tb4;
// ------------------------------------------------
// instance
// ------------------------------------------------
reg		rst_n	;
reg		clk	;
wire	[3:0]	q	;

initial		clk = 1'b0	;
always	#(100)	clk = ~clk	;

counter_4	dut_0 ( .q ( q ), .rst_n ( rst_n ), .clk ( clk ));

// ------------------------------------------------
// stimulus
// ------------------------------------------------

initial begin
#(0)	rst_n = 1'b0;
#(50)	rst_n = 1'b1;	#(50)	$display("%b\t%b\t%b\t%b1", q[3], q[2], q[1], q[0]);
#(50)	rst_n = 1'b1;	#(50)	$display("%b\t%b\t%b\t%b2", q[3], q[2], q[1], q[0]);
#(50)	rst_n = 1'b1;	#(50)	$display("%b\t%b\t%b\t%b3", q[3], q[2], q[1], q[0]);
#(50)	rst_n = 1'b1;	#(50)	$display("%b\t%b\t%b\t%b4", q[3], q[2], q[1], q[0]);
#(50)	rst_n = 1'b1;	#(50)	$display("%b\t%b\t%b\t%b5", q[3], q[2], q[1], q[0]);
#(50)	rst_n = 1'b1;	#(50)	$display("%b\t%b\t%b\t%b6", q[3], q[2], q[1], q[0]);
#(50)	rst_n = 1'b1;	#(50)	$display("%b\t%b\t%b\t%b7", q[3], q[2], q[1], q[0]);
#(50)	rst_n = 1'b1;	#(50)	$display("%b\t%b\t%b\t%b8", q[3], q[2], q[1], q[0]);
#(50)	rst_n = 1'b1;	#(50)	$display("%b\t%b\t%b\t%b9", q[3], q[2], q[1], q[0]);
#(50)	rst_n = 1'b1;	#(50)	$display("%b\t%b\t%b\t%b0", q[3], q[2], q[1], q[0]);
#(50)	rst_n = 1'b1;	#(50)	$display("%b\t%b\t%b\t%b1", q[3], q[2], q[1], q[0]);
#(50)	rst_n = 1'b1;	#(50)	$display("%b\t%b\t%b\t%b2", q[3], q[2], q[1], q[0]);
#(50)	rst_n = 1'b1;	#(50)	$display("%b\t%b\t%b\t%b3", q[3], q[2], q[1], q[0]);
#(50)	$finish;
end

endmodule
