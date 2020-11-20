// ---------------------------------------------------------
//             ir sensor remote control
// Assignment: week 9
// Course: practice in digital logic design
// return pressed controller button value at FPGA display
// --------------------- list ---------------------
// 01. NCO (1M Hz) << week5 P1
// 02. FND decoder << week5 P1
// 03. LED display << week5 P1
// 04. ir_rx
// 05. Top module
// ---------------------------------------------------------

// ------------------------------------------------
// NCO (1M Hz)
// ------------------------------------------------
module nco ( clk_gen, num, clk, rst_n );

output		clk_gen	;
input	[31:0]	num	;
input		clk	;
input		rst_n	;

reg	[31:0]	cnt	;
reg		clk_gen	;

always	@(posedge clk or negedge rst_n) begin
	if (rst_n == 1'b0) begin // reset
		cnt	<= 32'd0;
		clk_gen	<= 1'd0	;
	end else begin
		if (cnt >= num/2-1) begin
			cnt	<= 32'd0	;
			clk_gen	<= ~clk_gen	;
		end else begin
			cnt	<= cnt + 1'b1	;
		end
	end
end
endmodule

// ------------------------------------------------
// FND decoder
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
// LED display
// ------------------------------------------------
module	led_disp ( o_seg, o_seg_dp, o_seg_enb, i_six_digit_seg, i_six_dp, clk, rst_n );

output	[5:0]	o_seg_enb	;	// common cathod
output		o_seg_dp	;	// chosen common cathod's dot
output	[6:0]	o_seg		;	// chosen common cathod's 7 seg

input	[41:0]	i_six_digit_seg	;	// all segment
input	[5:0]	i_six_dp	;	// all dot
input		clk		;
input		rst_n		;

wire		clk_gen		;

// *********************** .o_gen_clk (x), .clk_gen modified (o) ***********************
nco	u_nco ( .clk_gen ( clk_gen ), .num ( 32'd100000 ), .clk ( clk ), .rst_n ( rst_n ));	// num *= 1/100

reg	[3:0]	cnt_common_node	;

always	@(posedge clk_gen or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		cnt_common_node <= 4'd0;
	end else begin
		if (cnt_common_node >= 4'd5) begin // 0~5 counter for common cathod
			cnt_common_node <= 4'd0;
		end else begin
			cnt_common_node <= cnt_common_node + 1'b1;
		end
	end
end

reg	[5:0]	o_seg_enb	;

always	@(cnt_common_node) begin
	case (cnt_common_node)
		4'd0 : o_seg_enb = 6'b111110;
		4'd1 : o_seg_enb = 6'b111101;
		4'd2 : o_seg_enb = 6'b111011;
		4'd3 : o_seg_enb = 6'b110111;
		4'd4 : o_seg_enb = 6'b101111;
		4'd5 : o_seg_enb = 6'b011111;
	endcase
end

reg		o_seg_dp	;

always	@(cnt_common_node) begin
	case (cnt_common_node)
		4'd0 : o_seg_dp = i_six_dp[0];
		4'd1 : o_seg_dp = i_six_dp[1];
		4'd2 : o_seg_dp = i_six_dp[2];
		4'd3 : o_seg_dp = i_six_dp[3];
		4'd4 : o_seg_dp = i_six_dp[4];
		4'd5 : o_seg_dp = i_six_dp[5];
	endcase
end

reg	[6:0]	o_seg		;

always	@(cnt_common_node) begin
	case (cnt_common_node)
		4'd0 : o_seg = i_six_digit_seg[6:0];
		4'd1 : o_seg = i_six_digit_seg[13:7];
		4'd2 : o_seg = i_six_digit_seg[20:14];
		4'd3 : o_seg = i_six_digit_seg[27:21];
		4'd4 : o_seg = i_six_digit_seg[34:28];
		4'd5 : o_seg = i_six_digit_seg[41:35];
	endcase
end

endmodule

// ------------------------------------------------
// ir_rx
// ------------------------------------------------
module ir_rx ( o_data, i_ir_rxb, clk, rst_n );

output	[31:0]	o_data		;
input		i_ir_rxb	;
input		clk		;
input		rst_n		;

parameter IDLE	= 2'b00		;
parameter LEADCODE = 2'b01	;
parameter DATACODE = 2'b10	;
parameter COMPLETE = 2'b11	;

// 1M Clock = 1μs reference Time ( check signal every 1μs(1/10^6 sec) )
wire		clk_1M		;
nco		u_nco ( .clk_gen ( clk_1M ), .num ( 32'd50 ), .clk ( clk ), .rst_n ( rst_n )); // num = 32'd50000000 : 1Hz clk

wire		ir_rx		;
assign	ir_rx = ~i_ir_rxb	;

reg	[1:0]	seq_rx		; // present state

// seq_rx = {prev signal, present signal} (1μs)
always	@(posedge clk_1M or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		seq_rx <= 2'b00;
	end else begin
		seq_rx <= {seq_rx[0], ir_rx};
	end
end

// Count Signal Polarity (High & Low) (1μs)
reg	[15:0]	cnt_h		;
reg	[15:0]	cnt_l		;
always	@(posedge clk_1M or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		cnt_h <= 16'd0;
		cnt_l <= 16'd0;
	end else begin
		case (seq_rx)
			2'b00: cnt_l <= cnt_l + 1;
			2'b01: begin // 0 -> 1 reset
				cnt_l <= 16'd0;
				cnt_h <= 16'd0;
			end
			2'b11: cnt_h <= cnt_h + 1;
		endcase
	end
end

reg	[1:0]	state		;
reg	[5:0]	cnt32		;

// state checking (1μs)
always	@(posedge clk_1M or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		state <= IDLE;
		cnt32 <= 6'd0;
	end else begin
		case (state)
			IDLE: begin
				state <= LEADCODE;
				cnt32 <= 6'd0;
			end
			LEADCODE: begin // (1ms = 1000μs)
				if (cnt_h >= 8500 && cnt_l >= 4000) begin
					state <= DATACODE;
				end else begin
					state <= LEADCODE;
				end
			end
			DATACODE: begin
				if (seq_rx == 2'b01) begin
					cnt32 <= cnt32 + 1;
				end else begin
					cnt32 <= cnt32;
				end
				if (cnt32 >= 6'd32 & cnt_l >= 1000) begin
					state <= COMPLETE;
				end else begin
					state <= DATACODE;
				end
			end
			COMPLETE: state <= IDLE;
		endcase
	end
end

// 32bit Custom & Data Code
reg	[31:0]	data	;
reg	[31:0]	o_data	;

always	@(posedge clk_1M or negedge rst_n) begin
	if (rst_n == 1'b0) begin
		data <= 32'd0;
	end else begin
		case (state)
			DATACODE: begin
				if (cnt_l >= 1000) begin // 1bit
					data[32-cnt32] <= 1'b1;
				end else begin // 0bit
					data[32-cnt32] <= 1'b0;
				end
			end
		endcase
	end
end

endmodule

// ------------------------------------------------
// top_module
// ------------------------------------------------
module top ( o_seg, o_seg_dp, o_seg_enb, i_ir_rxb, clk, rst_n );

output	[6:0]	o_seg		;
output		o_seg_dp	;
output	[5:0]	o_seg_enb	;

input		i_ir_rxb	;
input		clk		;
input		rst_n		;

wire	[31:0]	data		;
ir_rx		u0_ir_rx ( .o_data ( data ), .i_ir_rxb ( i_ir_rxb ), .clk ( clk ), .rst_n ( rst_n ) );

wire	[41:0]	six_digit_seg	;
fnd_dec		u0_fnd_dec ( .o_seg ( six_digit_seg[6:0] ), .i_num ( data[3:0] ) );
fnd_dec		u1_fnd_dec ( .o_seg ( six_digit_seg[13:7] ), .i_num ( data[7:4] ) );
fnd_dec		u2_fnd_dec ( .o_seg ( six_digit_seg[20:14] ), .i_num ( data[11:8] ) );
fnd_dec		u3_fnd_dec ( .o_seg ( six_digit_seg[27:21] ), .i_num ( data[15:12] ) );
fnd_dec		u4_fnd_dec ( .o_seg ( six_digit_seg[34:28] ), .i_num ( data[19:16] ) );
fnd_dec		u5_fnd_dec ( .o_seg ( six_digit_seg[41:35] ), .i_num ( data[23:20] ) );

led_disp	u_led_disp ( .o_seg ( o_seg ), .o_seg_dp ( o_seg_dp ), .o_seg_enb ( o_seg_enb ), .i_six_digit_seg ( six_digit_seg ), .i_six_dp ( 6'h0 ), .clk ( clk ), .rst_n ( rst_n ) );

endmodule
