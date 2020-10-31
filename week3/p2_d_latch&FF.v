// ---------------------------------------------------------
// Latch & DFF Design
// lecture: practice in digital logic design
// week3 practice P2
// --------------------- list ---------------------
// P2A : D Latch w/ reset
// P2B : D Flip-Flop (DFF) w/ Async & Sync. Reset
// ---------------------------------------------------------

// ------------------------------------------------
// P2A : D Latch w/ reset
// ------------------------------------------------
module d_latch	(	q, d, clk, rst_n	);

output	q	;
input	d	;
input	clk	;
input	rst_n	;

reg	q	;

always	@(d or clk or rst_n) begin
	if (rst_n == 1'b0) begin
		q <= 1'b0;
	end else begin
		if (clk == 1'b1) begin
			q <= d;
		end
	end
end
endmodule

// ------------------------------------------------
// P2B : D Flip-Flop (DFF) w/ Async & Sync. Reset
// ------------------------------------------------
module dff_asyn	(	q, d, clk, rst_n	);

output	q	;
input	d	;
input	clk	;
input	rst_n	;

reg	q	;

always	@(posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		q <= 1'b0;
	end else begin
		q <= d;
	end
end
endmodule

module dff_syn (	q, d, clk, rst_n	);

output	q	;
input	d	;
input	clk	;
input	rst_n	;

reg	q	;

always	@(posedge clk) begin
	if (rst_n == 1'b0) begin
		q <= 1'b0;
	end else begin
		q <= d;
	end
end
endmodule
