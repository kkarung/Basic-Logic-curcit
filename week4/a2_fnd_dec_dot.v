// ---------------------------------------------------------
// Subject: FND Design including DOT
// Assignment: week4 assignment A2
// Course: practice in digital logic design
// --------------------- list ---------------------
// A2: FND Display - DP
// FND decoder instance for FPGA
// ---------------------------------------------------------

// ------------------------------------------------
// A2: FND Display - DP
// ------------------------------------------------
module	fnd_dec_dot ( o_seg, i_num );

output	[7:0]	o_seg	;	// segment
input	[3:0]	i_num	;	// input number
reg	[7:0]	o_seg	;

always	@(*)	begin
	case (i_num)
		4'b0000 : o_seg = 8'b1111_1110;	// 0
		4'b0001 : o_seg = 8'b0110_0000;	// 1
		4'b0010 : o_seg = 8'b1101_1010;	// 2
		4'b0011 : o_seg = 8'b1111_0011;	// 3 + dot
		4'b0100 : o_seg = 8'b0110_0110;	// 4
		4'b0101 : o_seg = 8'b1011_0110;	// 5
		4'b0110 : o_seg = 8'b1011_1110;	// 6
		4'b0111 : o_seg = 8'b1110_0000;	// 7
		4'b1000 : o_seg = 8'b1111_1110;	// 8
		4'b1001 : o_seg = 8'b1110_0110;	// 9
		4'b1010 : o_seg = 8'b1110_1110;	// A
		4'b1011 : o_seg = 8'b0011_1110;	// B
		4'b1100 : o_seg = 8'b1001_1100;	// C
		4'b1101 : o_seg = 8'b0111_1010;	// D
		4'b1110 : o_seg = 8'b1001_1110;	// E
		4'b1111 : o_seg = 8'b1000_1110;	// F
		default : o_seg = 8'b0000_0000;
	endcase
end
endmodule

// ------------------------------------------------
// FND decoder instance for FPGA
// ------------------------------------------------
module	fnd_dec_fpga_dot ( o_com, o_seg );

output	[5:0]	o_com	;	// common cathod
output	[7:0]	o_seg	;	// segment

assign	o_com = 6'b010_101	;
fnd_dec_dot	u_fnd_dec_dot ( .o_seg ( o_seg ), .i_num ( 3 ));

endmodule
