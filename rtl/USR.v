module USR(clr,clk,sel,shift_en,data_in,out);
	input clr,clk,shift_en;
	input [1:0]sel;
	input [3:0]data_in;
	output reg[3:0]out;
	integer i;
	
	always @(posedge clk)
	begin
		if(clr)
			out=4'b0000;
		else
		begin
			if (sel == 2'b00)
				begin
				out <= data_in; 
				if(shift_en)
					for(i=0;i<3;i=i+1)
					begin
					out[i] <= out[i+1];
					out[3] <= 1'b0;
					end
				else
				out <= data_in;
				end
			else if (sel==2'b01)
			begin
		// out <= 4'd0;
			if(shift_en)
		for(i=0;i<4;i=i+1)
		begin
		out[i] <= out[i+1];
		out[3] <= data_in[i];
		end
		else
		out <= data_in;
		end
		else if (sel==2'b10)
			begin
			// out <= 4'd0;
			if(shift_en)
				for(i=3;i>-1;i=i-1)
				begin
				out[3] <= out[2];
				out[2] <= out[1];
				out[1] <= out[0];
				out[0] <= data_in[i];
				end
			else
				out <= data_in;
			end
		else
			begin
			if(shift_en)
			out <= data_in;
			else
			out <= 4'dx;
			end
		end
	end
endmodule
