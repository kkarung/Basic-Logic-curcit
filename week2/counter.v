// ---------------------------------------------------------
// N-bit Counter
// lecture: practice in digital logic design
// for week2 A2
// --------------------- list ---------------------
// N-bit Counter
// ----------------------------------------------------------

// ------------------------------------------------
// N-bit Counter
// ------------------------------------------------
module counter (	cnt, clk, rst_n	);

parameter		N = 2	;

output	[N-1:0]		cnt	;
input			clk	;
input			rst_n	;

reg	[N-1:0]		cnt	;

always @(posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		cnt	 <= 0	;
	end else begin
		cnt	<= cnt+1;
	end
end

endmodule
