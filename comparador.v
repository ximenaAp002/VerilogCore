module comparador # ( 
	parameter bitsEntry = 4,
	parameter bitsOut = 3
	)(
	input [bitsEntry-1:0] entradaA,
	input [bitsEntry-1:0] entradaB,
	output reg [bitsOut-1:0] salida
	
);

	always @(entradaA,entradaB)
	begin
		if(entradaA>entradaB)
			begin
				salida[2] = 1;
				salida[1] = 0;
				salida[0] = 0;
			end
		else if(entradaA<entradaB)
			begin
				salida[2] = 0;
				salida[1] = 1;
				salida[0] = 0;	
			end
		else 
			begin
				salida[2] = 0;
				salida[1] = 0;
				salida[0] = 1;			
			end
	end

endmodule
