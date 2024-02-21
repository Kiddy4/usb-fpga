Test Bench Code:
////////////////////////////////////////////////////////////////////////////////
// Company: HCMUTE
// Engineer: 	TRAN QUANG NHAT, PHAN NHU KHOI
//	Lecturer: DO DUY TAN
// Create Date:   11:49:02 05/24/2022
// Design Name:   USB1
//ModuleName:   C:/Users/Mike/OneDrive/Documents/Xilinx_ISE_DS_Win_14.7_1015_1/projects/USB1/USB1_tb.v
// Project Name:  USB1
// Target Device:  USB Transmission
// Tool versions:  
// Description: 
// Verilog Test Fixture created by ISE for module: USB1
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module USB1_tb;

	// Inputs
	reg CLOCK;
	reg RESET;
	reg [32:0] IN_TOKEN;
	reg [16:0] ACK_HANDS;
	reg [15:0] DATA_IN;

	// Outputs
	wire [15:0] D_BUS;
	wire LED;
	wire [3:0] NAK;

	// Instantiate the Unit Under Test (UUT)
	USB1 uut (
		.CLOCK(CLOCK), 
		.RESET(RESET), 
		.IN_TOKEN(IN_TOKEN), 
		.ACK_HANDS(ACK_HANDS), 
		.DATA_IN(DATA_IN), 
		.D_BUS(D_BUS), 
		.LED(LED), 
		.NAK(NAK)
	);

	initial begin
		// Initialize Inputs
		CLOCK = 0;
		RESET = 0;
		IN_TOKEN = 0;
		ACK_HANDS = 0;
		DATA_IN = 0;

		// Wait 100 ns for global reset to finish
		#100;
		RESET = 1'b1;
		#100;
        
		// Add stimulus here
		IN_TOKEN = 33'b00000001_00011110_00000010_00110101_0; // correct token, we want to read data, but this token is write data
		ACK_HANDS = 17'b00000001_00101101_1;	// correct  ACK feedback from USB peripherals
		DATA_IN = 16'b1001000111111111;
		
		#100;
		IN_TOKEN = 33'b00000001_10011111_00000010_00110101_0; // Wrong token, we want to read data, but this token is write data
		ACK_HANDS = 17'b00000001001011011;	// correct  ACK feedback from USB peripherals
		DATA_IN = 16'b1001000101110110;
		
		#100;
		IN_TOKEN = 33'b00000001_00011110_00000010_00110101_0; // correct token, we want to read data, but this token is write data
		ACK_HANDS = 17'b00000001_00101101_1;	// correct  ACK feedback from USB peripherals
		DATA_IN = 16'b1010010010010010;
		
		#100;
		RESET = 1'b0;
		
		
		#100
		RESET = 1'b1;
		IN_TOKEN = 33'b00000001_00011110_00000010_00110101_0; // correct token, we want to read data, but this token is write data
		ACK_HANDS = 17'b00000001_10100101_1;	// incorrect  ACK feedback from USB peripherals
		DATA_IN = 16'b1001000111111111;

	end
	
always
	begin
		CLOCK = ~ CLOCK;
		#10;
	end
      
endmodule
