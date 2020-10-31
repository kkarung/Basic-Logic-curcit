// ---------------------------------------------------------
//          FND(Flexible Numeric Display) Decoder
// Course: practice in digital logic design
// Assignment: week4 practice P3

// + FND Decoder: 7 segment display >> more details... https://dokkodai.tistory.com/89
// --------------------- list ---------------------
// P3: FND Decoder
// FND decoder instance for FPGA
// ---------------------------------------------------------

// ------------------------------------------------
// P3: FND Decoder
// ------------------------------------------------
module	fnd_dec ( o_seg, i_num );

output	[6:0]	o_seg	;	// segment
input	[3:0]	i_num	;	// input number
reg	[6:0]	o_seg	;

always	@(*)	begin
	case (i_num)
		4'b0000 : o_seg = 8'b111_1110;	// 0
		4'b0001 : o_seg = 8'b011_0000;	// 1
		4'b0010 : o_seg = 8'b110_1101;	// 2
		4'b0011 : o_seg = 8'b111_1001;	// 3
		4'b0100 : o_seg = 8'b011_0011;	// 4
		4'b0101 : o_seg = 8'b101_1011;	// 5
		4'b0110 : o_seg = 8'b101_1111;	// 6
		4'b0111 : o_seg = 8'b111_0000;	// 7
		4'b1000 : o_seg = 8'b111_1111;	// 8
		4'b1001 : o_seg = 8'b111_0011;	// 9
		4'b1010 : o_seg = 8'b111_0111;	// A
		4'b1011 : o_seg = 8'b001_1111;	// B
		4'b1100 : o_seg = 8'b100_1110;	// C
		4'b1101 : o_seg = 8'b011_1101;	// D
		4'b1110 : o_seg = 8'b100_1111;	// E
		4'b1111 : o_seg = 8'b100_0111;	// F
		default : o_seg = 8'b000_0000;
	endcase
end
endmodule

// ------------------------------------------------
// FND decoder instance for FPGA
// ------------------------------------------------
module	fnd_dec_fpga ( o_com, o_seg );

output	[5:0]	o_com	;	// common cathod
output	[6:0]	o_seg	;	// segment

assign	o_com = 6'b010_101	;
fnd_dec	u_fnd_dec ( .o_seg ( o_seg ), .i_num ( 3 ));

endmodule
