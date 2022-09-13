module FSM_password (

   input clk, reset,
	input [3:0] contra, habil,
	output reg ok, s1,s2,s3, //salida solo para corroborar
	//input num1,num2,num3,num4,
	
	output reg [0:6] segmentosP, //Segmento que ilumina la P
	output reg [0:6] segmentosA, //Segmento que ilumina la A
	output reg [0:6] segmentosS, //Segmneto que ilumina la S
	output reg [0:6] segmentosS1 //Segmneto que ilumina la S

	
);
/*
	reg [3:0] num1 = 0;
	reg [3:0] num2 = 0;
	reg [3:0] num3 = 0;
	reg [3:0] num4 = 0;
*/
	
// DEFINICION Y ASIGNACIÓN DE ESTADOS
   parameter contra1 = 0,
				 contra2 = 1,
				 contra3 = 2,
				 contra4 = 3,
				 num1 = 1,
				 num2 = 9,
				 num3 = 8,
				 num4 = 0;
				 //state_ok = 4;
				 
// VARIABLESs PARA ALMACENAR EL ESTAD0 PRESENTE Y SIGUIENTE
reg [1:0] current_state, next_state;
	
// PROCESO DE CAMBIO DE ESTADO
always  @ (posedge clk , negedge reset)
// PROCESO SIGUIENTE ESTADO Y SALIDA
	begin
		if (!reset) //Recordar qye le quité la negación jeje
			current_state <= contra1;
		else
			current_state <= next_state;
	end

always @ (current_state, habil)
	begin
	ok = 0;
	segmentosP = ~(7'b1111110); //Buscar como hacer la P
	segmentosA = ~(7'b1111110);
	segmentosS = ~(7'b1111110);
	segmentosS1 = ~(7'b1111110);
	s1 = 0;
	s2 = 0;
	s3 = 0;
		case (current_state)
			contra1:
				begin
				if (habil[0])
					if (contra[0] == 1 )
					begin
						
						next_state = contra2;
					end
					else
						next_state = current_state;
				else 
					next_state = contra1;
				end
			contra2:
				begin
				s1 = 1;
				s2 = 0;
				s3 = 0;
				if (habil[1])
					if (contra[0] && contra[3] == 1)
					begin
						next_state = contra3;
					end
					else
						next_state = contra1;
				else 
					next_state = current_state;	
				end
			contra3:
			   begin
				s2 = 1;
				s1 = 1;
				s3 = 0;
				if (habil[2])
					if (contra[3] == 1)
					begin
						s3 = 1;
						next_state = contra4;
					end
					else
						next_state = contra1;
				else 
					next_state = current_state;	
				end
			contra4:
				begin
				s1 = 1;
				s2 = 1;
				s3 = 1;
				ok = 1;
				segmentosP = ~(7'b1100111); //Buscar como hacer la P
				segmentosA = ~(7'b1110111);
				segmentosS = ~(7'b1011011);
				segmentosS1 = ~(7'b1011011);
				if (habil[3])
					if (contra == num4)
						next_state <= contra1;
					else
						next_state = current_state;
				else 
					next_state = current_state;	
				end
			/*
			state_ok:
				begin
					ok = 1;
					segmentosP = ~(7'b1100111); //Buscar como hacer la P
					segmentosA = ~(7'b1110111);
					segmentosS = ~(7'b0110011);
					segmentosS1 = ~(7'b0110011);
					next_state <= contra1;
				end
			*/
		endcase
	end
endmodule
