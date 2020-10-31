// ---------------------------------------------------------
//  SR Latch based DFF Design
// lecture: practice in digital logic design
// week3 assignment P1
// --------------------- list ---------------------
// A1 : SR Latch based DFF Design (Gate Level Description)
// ---------------------------------------------------------

// ------------------------------------------------------
// A1 : SR Latch based DFF Design (Gate Level Description)
// ------------------------------------------------------
module sr_slave (	q, q_n, s, r, clk	)	;

output	q	;
output	q_n	;
input	s	;
input	r	;
input	clk	;

wire	node1	;
wire	node2	;

nand	NAND_1(	node1, s, clk	)	;	// node1
nand	NAND_2(	node2, r, clk	)	;	// node2
nand	NAND_3( q, node1, q_n	)	;	// q
nand	NAND_4(	q_n, q, node2	)	;	// q_n

endmodule

module master_dff (	s, r, d, clk		)	;

output	s	;
output	r	;
input	d	;
input	clk	;

wire	d_n	;

not 		NOT_1		(	d_n, d	)	;
sr_slave	sr_1	(	s, r, d, d_n, clk	)	;

endmodule

module dff_sr(	q, q_n, d, clk	)	;	// "negative" edge triggerd d flip flop

output	q	;
output	q_n	;
input	d	;
input	clk	;

wire	node1	;
wire	node2	;
wire	clk_n	;

not	NOT_1	(	clk_n, clk		)	;
master_dff	dff_1	(	node1, node2, d, clk	)	;
sr_slave	sr_1	(	q, q_n, node1, node2, clk_n	);

endmodule
