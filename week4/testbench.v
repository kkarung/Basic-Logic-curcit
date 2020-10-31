// ---------------------------------------------------------
//                       Test bench
// Course: practice in digital logic design
// Assignment: week4 practice 01,02 / assignment 01
// --------------------- list ---------------------
// tb for P1
// tb_cnt for P2
// tb_top_cnt for A1
// ----------------------------------------------------------

`timescale	1ns/1ns

module tb;
// ------------------------------------------------
// instance
// ------------------------------------------------

wire		clk_gen	;
reg	[31:0]	num	;
reg		clk	;
reg		rst_n	;

parameter	tCK = 1000/50	;	// 50MHz clk for FPGA input

initial		clk = 1'b0	;
always	#(tCK/2)
	clk = ~clk	;

nco	dut ( .clk_gen ( clk_gen ), .num ( 32'd50000000 ), .clk ( clk ), .rst_n ( rst_n )); // num 5x10(7)

// ------------------------------------------------
// stimulus
// ------------------------------------------------

initial begin
	#(00*tCK)	rst_n	= 1'b0	;
	#(10*tCK)	rst_n	= 1'b1	;
	#(100000000*tCK)	$finish	;
end
endmodule

module tb_cnt;
// ------------------------------------------------
// instance
// ------------------------------------------------

parameter tCK	= 1000/50	; // 50MHz clock

reg		clk	;
reg		rst_n	;
wire	[5:0]	out	;

initial		clk = 1'b0	;
always #(tCK/2)	clk = ~clk	;

cnt60	dut ( .out ( out ), .clk ( clk ), .rst_n ( rst_n ));

// ------------------------------------------------
// stimulus
// ------------------------------------------------

initial begin
#(0*tCK)	rst_n = 1'b0;
#(1*tCK)	rst_n = 1'b1;
#(100*tCK)	$finish;
end
endmodule

module tb_top_cnt;

// ------------------------------------------------
// instance
// ------------------------------------------------

parameter	tCK = 1000/50	;

reg		clk		;
reg		rst_n		;
wire	[5:0]	out		;

initial		clk = 1'b0	;
always #(tCK/2)	clk = ~clk	;

top_cnt	dut ( .out ( out ), .num ( 32'd50000000 ), .clk ( clk ), .rst_n ( rst_n ));

// ------------------------------------------------
// stimulus
// ------------------------------------------------

initial begin
	#(0*tCK) rst_n = 1'b0;
	#(1*tCK) rst_n = 1'b1;
	#(100000000*tCK) $finish;
end
endmodule
