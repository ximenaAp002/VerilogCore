module ALU_Integrada #(parameter Bits = 4)(
	
//entradas y salidas de la alu	
	input [Bits-1:0] selectores	,
	input [Bits-1:0] entrada1 , entrada2,
	output [2*Bits-1:0] salida,
	
	//Salidas de los números de las entradas
	output [6:0] seg_decenas1, seg_unidades1, seg_decenas2, 
	seg_unidades2, seg_centenas_salida, seg_decenas_salida, seg_unidades_salida

);
 
wire unidades_1 = entrada1 %10;
wire decenas_1 = entrada1 /10;

wire unidades_2 = entrada2 %10;
wire decenas_2= entrada2 /10;



letrero UNIDADES_ENTRADA1(
	.in(unidades_1),
	.segmentos(seg_unidades1)
);
	
letrero DECENAS_ENTRADA1(
	.in(decenas_1) ,
	.segmentos(seg_decenas1)
);
	
letrero UNIDADES_ENTRADA2(
	.in(unidades_2 ),
	.segmentos(seg_unidades2)
);
	
letrero DECENAS_ENTRADA2(
	.in(decenas_2) ,
	.segmentos(seg_decenas2)
);
	
	
ALU unidad_aritemitca_logica(
.selectores(selectores)	,
.entrada1(entrada1),
.entrada2(entrada2),
.salida(salida) //Recordar que aquí le cambiaste el nombre jeje
);

wire centenas_salida = salida%100;
wire decenas_salida = (salida%100)/10;
wire unidades_salida = (salida%100)%10;

letrero CENTENAS_SALIDA(
	.in(centenas_salida),
	.segmentos(seg_centenas_salida)
);
	
letrero DECENAS_SALIDA(
	.in(decenas_salida) ,
	.segmentos(seg_decenas_salida)
);
	
letrero UNIDADES_SALIDA(
	.in(unidades_salida),
	.segmentos(seg_unidades_salida)
);

endmodule
